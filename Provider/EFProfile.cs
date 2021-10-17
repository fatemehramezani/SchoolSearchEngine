using System;
using System.Collections.Generic;
using System.Configuration.Provider;
using System.Linq;
using System.Web.Security;
using System.Collections.Specialized;
using System.Configuration;
using System.Web.Configuration;
using System.Data;
using System.Web.Profile;
using DataLayer;
using System.Security.Permissions;
using System.Text;
using System.IO;
using System.Globalization;
using System.Linq.Expressions;

namespace Provider
{
    public class EFProfile : ProfileProvider
    {
        private string connectionString;

        public override void Initialize(string name, NameValueCollection config)
        {
            // Initialize values from web.config.
            if (config == null)
            {
                throw new ArgumentNullException("config");
            }

            if (string.IsNullOrEmpty(name))
            {
                name = "EFProfileProvider";
            }

            if (string.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "Ramezani EF Membership Provider");
            }

            // Initialize the abstract base class.
            base.Initialize(name, config);
        }

        public override SettingsPropertyValueCollection GetPropertyValues(SettingsContext context,
                                                                          SettingsPropertyCollection properties)
        {
            SettingsPropertyValueCollection settings = new SettingsPropertyValueCollection();
            if (properties.Count == 0)
                return settings;
            string username = (string) context["UserName"];
            if (String.IsNullOrEmpty(username))
                return settings;
            DataManager databaseEntities = new DataManager("DatabaseEntities");
            User user = databaseEntities.User.FirstOrDefault(item => item.Username == username);

            if (user.Profile != null && user.Role.Count(role => role.Name == "Manager") > 0)
            {
                foreach (SettingsProperty property in properties)
                {
                    if (property.SerializeAs == SettingsSerializeAs.ProviderSpecific)
                    {                        
                        if (property.PropertyType.IsPrimitive || property.PropertyType == typeof(string))
                            property.SerializeAs = SettingsSerializeAs.String;
                        else
                            property.SerializeAs = SettingsSerializeAs.Xml;
                    }
                    settings.Add(new SettingsPropertyValue(property));
                }
                ExtractPropertyValuesFromDatabase(username, settings);
            }
            else
            {
                foreach (SettingsProperty property in properties)
                {
                    property.SerializeAs = SettingsSerializeAs.String;
                    SettingsPropertyValue setting = new SettingsPropertyValue(property);
                    setting.IsDirty = false;
                    setting.Deserialized = true;
                    setting.PropertyValue = GetPropertyValue(setting.Name, setting.Property.PropertyType.FullName,
                                                             setting.Property.DefaultValue, user);
                    settings.Add(setting);
                }
            }
            return settings;
        }

        private object GetPropertyValue(string propertyName, string propertyType, object defaultValue, User user)
        {
            object value = defaultValue;            
            try
            {
                switch (propertyName)
                {
                    case "UserId":
                        value = user.Id;
                        break;
                    case "FirstName":
                        value = user.FirstName;
                        break;
                    case "LastName":
                        value = user.LastName;
                        break;
                    case "FullName":
                        value = string.Format("{0} {1}", user.FirstName, user.LastName);
                        break;
                    case "Email":
                        value = user.Email;
                        break;
                    case "Mobile":
                        value = user.Mobile;
                        break;
                    case "Phone":
                        value = user.Phone;
                        break;
                    //case "Address":
                    //    value = user.Address;
                    //    break;
                    case "ApplicantId":
                        DataManager databaseEntities = new DataManager("DatabaseEntities");
                        databaseEntities = new DataManager("DatabaseEntities");
                        Applicant applicant =
                            databaseEntities.Applicant.FirstOrDefault(item => item.UserId == user.Id);
                        if (applicant != null)
                            value = applicant.Id;
                        break;
                    default:
                        return value;
                }
            }
            catch
            {
            }
            switch (propertyType)
            { 
                case "System.Guid":
                    return new Guid(value.ToString());
                case "System.Int64":
                    return Convert.ToInt64(value);
                case "System.Int32":
                    if (value == string.Empty)
                        return value;
                    return Convert.ToInt32(value);
                case "System.String":
                    return Convert.ToString(value);
                default:
                    return value;
            }
        }

        public override void SetPropertyValues(SettingsContext context, SettingsPropertyValueCollection properties)
        {
            string username = (string)context["UserName"];

            if (string.IsNullOrEmpty(username) || properties.Count < 1)
            {
                return;
            }

            bool userIsAuthenticated = (bool)context["IsAuthenticated"];
            string propertiesNames = string.Empty;
            string propertiesValuesSerialized = string.Empty;
            byte[] propertiesValuesBinary = null;

            PrepareDataForSaving(ref propertiesNames, ref propertiesValuesSerialized, ref propertiesValuesBinary, properties, userIsAuthenticated);

            if (propertiesNames.Length != 0)
            {
                using (DataManager databaseEntities = new DataManager("DatabaseEntities"))
                {
                    // Attempt to load user with associated profile
                    User user = databaseEntities.User.Include("Profile").Where(u => u.Username == username).FirstOrDefault();

                    if (user == null)
                    {
                        throw new ArgumentException("user");
                    }

                    if (user.Profile == null)
                    {
                        // Create new profile
                        user.Profile = new DataLayer.Profile();
                    }

                    // Set profile values
                    user.Profile.PropertyNames = propertiesNames;
                    user.Profile.PropertyValuesString = propertiesValuesSerialized;
                    user.Profile.PropertyValuesBinary = propertiesValuesBinary;
                    user.Profile.LastUpdatedDate = DateTime.Now;
                    databaseEntities.SaveChanges();
                }
            }
        }

        /// <summary>
        /// Prepares the data for saving.
        /// </summary>
        /// <param name="propertiesNames">The properties names.</param>
        /// <param name="propertiesValuesSerialized">The properties values serialized.</param>
        /// <param name="propertiesValuesBinary">The properties values binary.</param>
        /// <param name="properties">The properties.</param>
        /// <param name="userIsAuthenticated">if set to <c>true</c> [user is authenticated].</param>
        [SecurityPermission(SecurityAction.Assert, Flags = SecurityPermissionFlag.SerializationFormatter)]
        private static void PrepareDataForSaving(ref string propertiesNames, ref string propertiesValuesSerialized, ref byte[] propertiesValuesBinary, SettingsPropertyValueCollection properties, bool userIsAuthenticated)
        {
            StringBuilder propertiesNamesBuilder = new StringBuilder();
            StringBuilder propertiesValuesSerializedBuilder = new StringBuilder();
            MemoryStream propertiesValuesBinarySerialized = new MemoryStream();
            try
            {
                try
                {
                    List<SettingsPropertyValue> relevantValues = properties.Cast<SettingsPropertyValue>()
                                                                           .Where(v => v.IsDirty && (userIsAuthenticated || (bool)v.Property.Attributes["AllowAnonymous"]))
                                                                           .ToList();
                    if (relevantValues.Count == 0)
                    {
                        return;
                    }

                    foreach (SettingsPropertyValue value in relevantValues)
                    {
                        int length;
                        int startPosition = 0;
                        string stringValue = null;

                        if (value.Deserialized && value.PropertyValue == null)
                        {
                            length = -1;
                        }
                        else
                        {
                            if (value.SerializedValue == null)
                            {
                                length = -1;
                            }
                            else
                            {
                                if (value.SerializedValue is string)
                                {
                                    stringValue = (string)value.SerializedValue;
                                    length = stringValue.Length;
                                    startPosition = propertiesValuesSerializedBuilder.Length;
                                }
                                else
                                {
                                    byte[] serializedBinary = (byte[])value.SerializedValue;
                                    startPosition = (int)propertiesValuesBinarySerialized.Position;
                                    propertiesValuesBinarySerialized.Write(serializedBinary, 0, serializedBinary.Length);
                                    propertiesValuesBinarySerialized.Position = startPosition + serializedBinary.Length;
                                    length = serializedBinary.Length;
                                }
                            }
                        }

                        propertiesNamesBuilder.Append(value.Name + ":");
                        propertiesNamesBuilder.Append((stringValue != null ? "S" : "B") + ":");
                        propertiesNamesBuilder.Append(startPosition.ToString(CultureInfo.InvariantCulture) + ":");
                        propertiesNamesBuilder.Append(length.ToString(CultureInfo.InvariantCulture) + ":");

                        if (stringValue != null)
                        {
                            propertiesValuesSerializedBuilder.Append(stringValue);
                        }
                    }

                    propertiesValuesBinary = propertiesValuesBinarySerialized.ToArray();
                }
                finally
                {
                    propertiesValuesBinarySerialized.Close();
                }
            }
            catch (Exception ex)
            {
                throw new ProviderException("Error while prepare data for saving.", ex);
            }

            propertiesNames = propertiesNamesBuilder.ToString();
            propertiesValuesSerialized = propertiesValuesSerializedBuilder.ToString();
        }
        /// <summary>
        /// Gets the property values from database.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="propertiesValues">The property values.</param>
        private void ExtractPropertyValuesFromDatabase(string userName, SettingsPropertyValueCollection propertiesValues)
        {
            string[] propertyNames = null;
            string propertiesValuesSerialized = null;
            byte[] propertiesValuesBinary = null;

           using (DataManager databaseEntities = new DataManager("DatabaseEntities"))
                {
                User user = databaseEntities.User.Include("Profile").Where(u => u.Username == userName && u.Profile != null).FirstOrDefault();
                if (user != null)
                {
                    propertyNames = user.Profile.PropertyNames.Split(new[] { ':' });
                    propertiesValuesSerialized = user.Profile.PropertyValuesString;
                    propertiesValuesBinary = user.Profile.PropertyValuesBinary;

                    // Update user
                    user.LastActivityDate = DateTime.Now;
                    databaseEntities.SaveChanges();
                }
            }

            ParseDataFromDatabase(propertyNames, propertiesValuesSerialized, propertiesValuesBinary, propertiesValues);
        }
        
        /// <summary>
        /// Parses the data from database.
        /// </summary>
        /// <param name="propertiesNames">The properties names.</param>
        /// <param name="propertiesValuesSerialized">The properties values serialized.</param>
        /// <param name="propertiesValuesBinary">The properties values binary.</param>
        /// <param name="propertiesValues">The properties values.</param>
        [SecurityPermission(SecurityAction.Assert, Flags = SecurityPermissionFlag.SerializationFormatter)]
        private static void ParseDataFromDatabase(string[] propertiesNames, string propertiesValuesSerialized, byte[] propertiesValuesBinary, SettingsPropertyValueCollection propertiesValues)
        {
            // Validate parameters
            if ((propertiesNames == null || propertiesValuesSerialized == null) || (propertiesValuesBinary == null || propertiesValues == null))
            {
                return;
            }

            try
            {
                for (int i = 0; i < (propertiesNames.Length / 4); i++)
                {
                    // Each property name definition consists of four parts (property name, serialization mode, data start index, data length)
                    string propertyName = propertiesNames[i * 4];
                    SettingsPropertyValue propertyValue = propertiesValues[propertyName];
                    if (propertyValue != null)
                    {
                        int startIndex = int.Parse(propertiesNames[(i * 4) + 2], CultureInfo.InvariantCulture);
                        int length = int.Parse(propertiesNames[(i * 4) + 3], CultureInfo.InvariantCulture);
                        if (length == -1 && !propertyValue.Property.PropertyType.IsValueType)
                        {
                            // No property value present
                            propertyValue.PropertyValue = null;
                            propertyValue.IsDirty = false;
                            propertyValue.Deserialized = true;
                        }

                        // Validate index and length
                        if (startIndex >= 0 &&
                            length > 0 &&
                            propertiesValuesSerialized.Length >= startIndex + length)
                        {
                            if (propertiesNames[(i * 4) + 1] == "S")
                            {
                                // String serialized data
                                propertyValue.SerializedValue = propertiesValuesSerialized.Substring(startIndex, length);
                            }
                            else if (propertiesNames[(i * 4) + 1] == "B")
                            {
                                // Binary data
                                byte[] serializedValue = new byte[length];
                                Buffer.BlockCopy(propertiesValuesBinary, startIndex, serializedValue, 0, length);
                                propertyValue.SerializedValue = serializedValue;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new ProviderException("Error while parsing values from database.", ex);
            }
        }

        #region Not Implemented Members

        public override int DeleteInactiveProfiles(ProfileAuthenticationOption authenticationOption,
                                                   DateTime userInactiveSinceDate)
        {
            throw new NotSupportedException();
        }

        public override int DeleteProfiles(string[] usernames)
        {
            throw new NotSupportedException();
        }

        public override int DeleteProfiles(ProfileInfoCollection profiles)
        {
            throw new NotSupportedException();
        }

        public override ProfileInfoCollection FindInactiveProfilesByUserName(
            ProfileAuthenticationOption authenticationOption, string usernameToMatch, DateTime userInactiveSinceDate,
            int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotSupportedException();
        }

        public override ProfileInfoCollection FindProfilesByUserName(ProfileAuthenticationOption authenticationOption,
                                                                     string usernameToMatch, int pageIndex, int pageSize,
                                                                     out int totalRecords)
        {
            throw new NotSupportedException();
        }

        public override ProfileInfoCollection GetAllInactiveProfiles(ProfileAuthenticationOption authenticationOption,
                                                                     DateTime userInactiveSinceDate, int pageIndex,
                                                                     int pageSize, out int totalRecords)
        {
            throw new NotSupportedException();
        }

        public override ProfileInfoCollection GetAllProfiles(ProfileAuthenticationOption authenticationOption,
                                                             int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotSupportedException();
        }

        public override int GetNumberOfInactiveProfiles(ProfileAuthenticationOption authenticationOption,
                                                        DateTime userInactiveSinceDate)
        {
            throw new NotSupportedException();
        }

        public override string ApplicationName
        {
            get { throw new NotSupportedException(); }
            set { throw new NotSupportedException(); }
        }

        #endregion
    }
}
