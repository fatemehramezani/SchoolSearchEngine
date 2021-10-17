using System.Configuration;
using System.Data.Entity;
using System.Xml;

namespace DataLayer
{
    public partial class DatabaseEntities : DbContext
    {
        public DatabaseEntities(string ConnectionString)
            : base(ConnectionString)
        {
        }
    }
    public sealed class ConfigurationService : IConfigurationSectionHandler
    {
        #region Fields
        /// <summary>
        /// name of the config section
        /// </summary>
        private const string ConfigSectionName = "CustomConfig";

        /// <summary>
        /// private lazy loaded connection string
        /// </summary>
        private static string _connectionString;

        /// <summary>
        /// flag denoting wether the config has been loaded.
        ///     only need once per application execution
        /// </summary>
        private static bool _init;

        #endregion

        #region Properties
        /// <summary>
        /// Internal static connection string
        ///     retrieves the value on the first execution to the
        ///     data storage schema on application load
        /// </summary>
        internal static string ConnectionString
        {
            get
            {
                if (!_init)
                    Init();
                return _connectionString;
            }
            set { _connectionString = value; }
        }

        #endregion

        #region Init
        /// <summary>
        /// Initializes the configuration section
        ///     by calling the ConfigurationManager.GetSection("section name") 
        ///     to load section properties
        /// </summary>
        private static void Init()
        {
            if (!_init)
            {
                ConfigurationManager.GetSection(ConfigSectionName);
                _init = true;
            }
        }
        #endregion

        #region IConfigurationSectionHandler Implementation
        /// <summary>
        /// exectes the configuration load
        /// </summary>
        /// <param name="parent"></param>
        /// <param name="configContext"></param>
        /// <param name="section"></param>
        /// <returns></returns>
        object IConfigurationSectionHandler.Create(object parent, object configContext, System.Xml.XmlNode section)
        {
            if (section != null)
                if (section.Attributes["ConnectionString"] != null)
                {
                    var conString = ConfigurationManager.ConnectionStrings[section.Attributes["ConnectionString"].Value];
                    if (conString != null)
                        ConnectionString = conString.ConnectionString;
                }
            return null;
        }

        #endregion
    }
    public partial class DataManager : DatabaseEntities
    {
        /// <summary>
        /// creates a new instance of the Data Manager using
        ///     the connection string from the configuration service
        /// </summary>
        public DataManager(): base(ConfigurationService.ConnectionString)
        {

        }

        /// <summary>
        /// creates a new instance of the Data Manager using
        ///     a provided connection string
        /// </summary>
        /// <param name="ConnectionString"></param>
        public DataManager(string ConnectionString): base(ConnectionString)
        {

        }

        /// <summary>
        /// close method, calls the dispose
        ///     methods. Not important, just easy to remeber
        ///     to 'close' all connections
        /// </summary>
        public void Close()
        {
            this.Dispose();
        }
    }
}