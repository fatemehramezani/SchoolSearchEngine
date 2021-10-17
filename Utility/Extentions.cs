using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web.UI;

namespace Utility
{
    public static class Extentions
    {
        public static void SetProperty(this object instance, string propertyName, object value)
        {
            var propertyInfo = instance.GetType().GetProperty(propertyName, BindingFlags.Public | BindingFlags.Instance);
            if (null != propertyInfo && propertyInfo.CanWrite)
                propertyInfo.SetValue(instance, ChangeType(value, propertyInfo.PropertyType), null);
        }

        public static Dictionary<string, object> GetProperties(this object data)
        {
            var type = data.GetType();
            return type.GetProperties().ToDictionary(propertyInfo => propertyInfo.Name, propertyInfo => propertyInfo.GetValue(data, null));
        }

        public static List<PropertyInfo> GetPropertiesInfo(this object data)
        {
            var type = data.GetType();
            return type.GetProperties().ToList();
        }

        public static object GetProperty(this object instance, string propertyName)
        {
            var propertyInfo = instance.GetType().GetProperty(propertyName, BindingFlags.Public | BindingFlags.Instance);
            return propertyInfo.GetValue(instance, null);
        }

        public static T ChangeType<T>(this object value)
        {
            return (T)ChangeType(value, typeof(T));
        }

        public static object ChangeType(this object value, Type type)
        {
            if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>) && value == null)
                return null;
            if (value.GetType() == type)
                return value;
            type = Nullable.GetUnderlyingType(type) ?? type;
            return (value == null || (value is string && string.IsNullOrEmpty(value as string))) ? null : Convert.ChangeType(value, type);
        }

        public static void ForEach<T>(this IEnumerable<T> source, Action<T> action)
        {
            source.ToList().ForEach(action);
        }

        public static IEnumerable<T> FindControlsOfType<T>(this Control parent) where T : Control
        {
            foreach (Control child in parent.Controls)
                if (child is T)
                    yield return (T)child;
                else if (child.Controls.Count > 0)
                    foreach (var grandChild in child.FindControlsOfType<T>())
                        yield return grandChild;
        }

        public static T FindParentsOfType<T>(this Control control) where T : Control
        {
            if (control.Parent != null)
            {
                if (control.Parent is T)
                    return (T)control.Parent;
                return control.Parent.FindParentsOfType<T>();
            }
            return null;
        }

        public static LatLgn ToLatLng(string value)
        {
            if (string.IsNullOrEmpty(value))
                return new LatLgn();
            var sections = value.Split(',');
            return new LatLgn { Lat = sections[0].ChangeType<double>(), Lng = sections[1].ChangeType<double>() };
        }

        public static Func<T, bool> AppendCondition<T>(this Func<T, bool> condition1, Func<T, bool> condition2, bool isOrType = true)
        {
            if (condition1 == null)
                return condition2;
            if (condition2 == null)
                return condition1;
            if (isOrType)
                return i => condition1(i) || condition2(i);
            return i => condition1(i) && condition2(i);
        }

        public static TAttribute GetAttributeValue<TAttribute>(Type type) where TAttribute : Attribute
        {
            return type.GetCustomAttributes(typeof(TAttribute), true).FirstOrDefault() as TAttribute;
        }

        public static string RemoveArabicEncoding(string text)
        {
            if (string.IsNullOrEmpty(text))
                return text;
            return text.Replace('ي', 'ی').Replace('ك', 'ک').Replace('و', 'و');
        }

        public static string MakeUtmLocation(double Lat, double Long)
        {
            string Zone;
            double UTMNorthing, UTMEasting;
            double a = 6378137; //WGS84
            var eccSquared = 0.00669438; //WGS84
            var k0 = 0.9996;

            double LongOrigin;
            double eccPrimeSquared;
            double N, T, C, A, M;

            //Make sure the longitude is between -180.00 .. 179.9
            var LongTemp = (Long + 180) - ((int)((Long + 180) / 360)) * 360 - 180; // -180.00 .. 179.9;

            var deg2rad = 0.017453292;

            var LatRad = Lat * deg2rad;
            var LongRad = LongTemp * deg2rad;
            double LongOriginRad;
            int ZoneNumber;

            ZoneNumber = ((int)((LongTemp + 180) / 6)) + 1;

            if (Lat >= 56.0 && Lat < 64.0 && LongTemp >= 3.0 && LongTemp < 12.0)
                ZoneNumber = 32;

            // Special zones for Svalbard
            if (Lat >= 72.0 && Lat < 84.0)
            {
                if (LongTemp >= 0.0 && LongTemp < 9.0) ZoneNumber = 31;
                else if (LongTemp >= 9.0 && LongTemp < 21.0) ZoneNumber = 33;
                else if (LongTemp >= 21.0 && LongTemp < 33.0) ZoneNumber = 35;
                else if (LongTemp >= 33.0 && LongTemp < 42.0) ZoneNumber = 37;
            }
            LongOrigin = (ZoneNumber - 1) * 6 - 180 + 3; //+3 puts origin in middle of zone
            LongOriginRad = LongOrigin * deg2rad;

            //compute the UTM Zone from the latitude and longitude
            Zone = ZoneNumber.ToString() + UTMLetterDesignator(Lat);

            eccPrimeSquared = (eccSquared) / (1 - eccSquared);

            N = a / Math.Sqrt(1 - eccSquared * Math.Sin(LatRad) * Math.Sin(LatRad));
            T = Math.Tan(LatRad) * Math.Tan(LatRad);
            C = eccPrimeSquared * Math.Cos(LatRad) * Math.Cos(LatRad);
            A = Math.Cos(LatRad) * (LongRad - LongOriginRad);

            M = a * ((1 - eccSquared / 4 - 3 * eccSquared * eccSquared / 64 - 5 * eccSquared * eccSquared * eccSquared / 256) * LatRad
                   - (3 * eccSquared / 8 + 3 * eccSquared * eccSquared / 32 + 45 * eccSquared * eccSquared * eccSquared / 1024) * Math.Sin(2 * LatRad)
                   + (15 * eccSquared * eccSquared / 256 + 45 * eccSquared * eccSquared * eccSquared / 1024) * Math.Sin(4 * LatRad)
                   - (35 * eccSquared * eccSquared * eccSquared / 3072) * Math.Sin(6 * LatRad));

            UTMEasting = k0 * N * (A + (1 - T + C) * A * A * A / 6
                               + (5 - 18 * T + T * T + 72 * C - 58 * eccPrimeSquared) * A * A * A * A * A / 120)
                         + 500000.0;

            UTMNorthing = k0 * (M + N * Math.Tan(LatRad) * (A * A / 2 + (5 - T + 9 * C + 4 * C * C) * A * A * A * A / 24
                                                      + (61 - 58 * T + T * T + 600 * C - 330 * eccPrimeSquared) * A * A * A * A * A * A / 720));
            if (Lat < 0)
                UTMNorthing += 10000000.0; //10000000 meter offset for southern hemisphere
            return string.Format("{0},{1}", UTMNorthing, UTMEasting);
        }

        private static char UTMLetterDesignator(double Lat)
        {
            char LetterDesignator;
            if ((84 >= Lat) && (Lat >= 72)) LetterDesignator = 'X';
            else if ((72 > Lat) && (Lat >= 64)) LetterDesignator = 'W';
            else if ((64 > Lat) && (Lat >= 56)) LetterDesignator = 'V';
            else if ((56 > Lat) && (Lat >= 48)) LetterDesignator = 'U';
            else if ((48 > Lat) && (Lat >= 40)) LetterDesignator = 'T';
            else if ((40 > Lat) && (Lat >= 32)) LetterDesignator = 'S';
            else if ((32 > Lat) && (Lat >= 24)) LetterDesignator = 'R';
            else if ((24 > Lat) && (Lat >= 16)) LetterDesignator = 'Q';
            else if ((16 > Lat) && (Lat >= 8)) LetterDesignator = 'P';
            else if ((8 > Lat) && (Lat >= 0)) LetterDesignator = 'N';
            else if ((0 > Lat) && (Lat >= -8)) LetterDesignator = 'M';
            else if ((-8 > Lat) && (Lat >= -16)) LetterDesignator = 'L';
            else if ((-16 > Lat) && (Lat >= -24)) LetterDesignator = 'K';
            else if ((-24 > Lat) && (Lat >= -32)) LetterDesignator = 'J';
            else if ((-32 > Lat) && (Lat >= -40)) LetterDesignator = 'H';
            else if ((-40 > Lat) && (Lat >= -48)) LetterDesignator = 'G';
            else if ((-48 > Lat) && (Lat >= -56)) LetterDesignator = 'F';
            else if ((-56 > Lat) && (Lat >= -64)) LetterDesignator = 'E';
            else if ((-64 > Lat) && (Lat >= -72)) LetterDesignator = 'D';
            else if ((-72 > Lat) && (Lat >= -80)) LetterDesignator = 'C';
            else LetterDesignator = 'Z'; //Latitude is outside the UTM limits
            return LetterDesignator;
        }

        public static int? ToNullableInt32(this string s)
        {
            int i;
            if (Int32.TryParse(s, out i)) return i;
            return null;
        }
        public static int ToInteger(this TimeSpan time)
        {
            return int.Parse(time.Hours.ToString() + time.Minutes.ToString().PadLeft(2, '0') + time.Seconds.ToString().PadLeft(2, '0'));
        }

        public static short ToShort(this TimeSpan time)
        {
            return short.Parse(time.Hours.ToString() + time.Minutes.ToString().PadLeft(2, '0'));
        }

        public static string ToHHMM(this TimeSpan time)
        {
            return time.ToString("hh\\:mm");
        }

        public static string ToHHMMSS(this TimeSpan time)
        {
            return time.ToString("hh\\:mm\\:ss");
        }
    }

    public class LatLgn
    {
        public double? Lat { get; set; }
        public double? Lng { get; set; }
    }
}