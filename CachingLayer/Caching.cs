using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Caching;

namespace CachingLayer
{
    public static class Caching
    {

        #region AddToCache
        //public static void AddToCache(String name, Object data)
        //{
        //    if (HttpContext.Current.Cache[name] != null)
        //        HttpContext.Current.Cache.Remove(name);
        //    HttpContext.Current.Cache[name] = data;
        //}

        /// <summary>
        /// AddToCacheWithAbsoluteExpireTime
        /// </summary>
        /// <param name="name"></param>
        /// <param name="data"></param>
        /// <param name="absoluteExpiration"></param>
        public static void AddToCache(String name, Object data, DateTime absoluteExpiration)
        {
            if (HttpContext.Current.Cache[name] != null)
                HttpContext.Current.Cache.Remove(name);
            HttpContext.Current.Cache.Insert(name, data, null,
                                                absoluteExpiration,
                                                System.Web.Caching.Cache.NoSlidingExpiration);
        }

        /// <summary>
        /// AddToCacheWithSlidingExpiration
        /// </summary>
        /// <param name="name"></param>
        /// <param name="data"></param>
        /// <param name="slidingExpiration"></param>
        public static void AddToCache(String name, Object data, TimeSpan slidingExpiration)
        {
            if (HttpContext.Current.Cache[name] != null)
                HttpContext.Current.Cache.Remove(name);
            HttpContext.Current.Cache.Insert(name, data, null,
                                                System.Web.Caching.Cache.NoAbsoluteExpiration,
                                                slidingExpiration);
        }

        /// <summary>
        /// AddToCacheWithSlidingExpiration
        /// </summary>
        /// <param name="name"></param>
        /// <param name="data"></param>
        /// <param name="slidingExpiration"></param>
        public static void AddToCache(String name, Object data, Int16 timeInSeconds = (Int16)120)
        {
            if (HttpContext.Current.Cache[name] != null)
                HttpContext.Current.Cache.Remove(name);
            HttpContext.Current.Cache.Insert(name, data, null,
                                                System.Web.Caching.Cache.NoAbsoluteExpiration,
                                                new TimeSpan(0, 0, timeInSeconds));
        }
        #endregion

        #region GetFromCache
        public static Object GetFromCache(String name)
        {
            return HttpContext.Current.Cache[name];
        }
        #endregion

        #region RemoveFromCache
        public static void RemoveFromCache(String name)
        {
            if (HttpContext.Current.Cache[name] != null)
                HttpContext.Current.Cache.Remove(name);
        }
        #endregion
    }
}
