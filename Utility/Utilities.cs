using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Utility
{
    public static class Utilities
    {
        public static string JoinCsv<T>(this IEnumerable<T> source)
        {
            if (source == null || !source.Any())
                return null;
            return string.Join(",", source.Select(i => i.ToString()));
        }

        public static IEnumerable<T> SplitCsv<T>(this string source)
        {
            if (string.IsNullOrEmpty(source))
                return Enumerable.Empty<T>();
            return source.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(i => (T)i.ChangeType(typeof(T)));
        }

        public static string ComputeHash(string encryptionValue)
        {
            MD5 encryptor = new MD5CryptoServiceProvider();
            return Convert.ToBase64String(encryptor.ComputeHash(Encoding.Unicode.GetBytes(encryptionValue)));
        }
        public static Dictionary<string, object> GetProperties(this object data)
        {
            Type type = data.GetType();
            return type.GetProperties().ToDictionary(propertyInfo => propertyInfo.Name, propertyInfo => propertyInfo.GetValue(data));
        }
        public static T UrlArgument<T>(string key)
        {
            if (HttpContext.Current.Request.QueryString[key] == null)
                return default(T);
            return (T)HttpContext.Current.Request.QueryString[key].ChangeType(typeof(T));
        }
        //public static object ChangeType(this object value, Type type)
        //{
        //    if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>) && value == null)
        //        return null;
        //    if (value.GetType() == type)
        //        return value;
        //    type = Nullable.GetUnderlyingType(type) ?? type;
        //    return (value == null || (value is string && string.IsNullOrEmpty(value as string))) ? null : Convert.ChangeType(value, type);
        //}

    }

    public enum MessageStatus
    {
        Success, Warning, Information, Error
    }

    public class ViewMessage
    {
        public MessageStatus Status { get; set; }
        public string Message { get; set; }

        public ViewMessage(MessageStatus status, string message = null)
        {
            Status = status;
            Message = message;
            if (message == null)
                switch (status)
                {
                    case MessageStatus.Error:
                        Message = "عملیات با شکست مواجه شد";
                        break;
                    case MessageStatus.Success:
                        Message = "عملیات با موفقیت انجام شد";
                        break;
                }
        }

        public string GetClass()
        {
            switch (Status)
            {
                case MessageStatus.Success:
                    return "btn-success";
                case MessageStatus.Warning:
                    return "btn-warning";
                case MessageStatus.Information:
                    return "btn-info";
                default:
                    return "btn-danger";
            }
        }
    }
}