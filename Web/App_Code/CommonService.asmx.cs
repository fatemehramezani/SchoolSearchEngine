using System;
using System.Linq;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web.Services;
using System.Web.Services.Protocols;
using AjaxControlToolkit;
using System.Data;
using System.Data.SqlClient;

namespace Service
{
    /// <summary>
    /// Summary description for Province
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService()]
    public class CommonService : System.Web.Services.WebService
    {
        public CommonService()
        {
        }

        #region GetLocations
        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public DataLayer.Location[] Locations(int parentId)
        {
            try {
                if (parentId < 1)
                    return new BusinessLayer.Common.Locations().Get().Where(e => e.ParentId == null).ToArray();
                else
                    return new BusinessLayer.Common.Locations().Get().Where(e => e.ParentId == parentId).ToArray();
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        #endregion

        #region GetCommons
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public DataLayer.Common[] Commons(int parentId)
        {
            try {
                if (parentId < 0)
                    return new BusinessLayer.Common.Commons().Get().Where(e => e.ParentId != null).ToArray();
                if (parentId < 1)
                    return new BusinessLayer.Common.Commons().Get().Where(e => e.ParentId == null).ToArray();
                else
                    return new BusinessLayer.Common.Commons().Get().Where(e => e.ParentId == parentId).ToArray();
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public DataLayer.Common[] CommonList()
        {
            return new BusinessLayer.Common.Commons().Get().Where(c=>c.ParentId != null).ToArray();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public List<DataLayer.Common> CommonDescendants(int id)
        {
            List<DataLayer.Common> result = new List<DataLayer.Common>();
            if (id < 1)
            {
                var children = new BusinessLayer.Common.Commons().Get().Where(c=>c.ParentId == null).ToList();
                //result.AddRange(children);
                foreach (var child in children)
                    result.AddRange(CommonDescendants(child.Id));
            }
            else
            {
                var children = new BusinessLayer.Common.Commons().GetByProperty(typeof(int), "ParentId", id.ToString()).ToList();
                result.AddRange(children);
                foreach (var child in children)
                    result.AddRange(CommonDescendants(child.Id));
            }
            return result.Distinct().ToList();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public DataLayer.Common CommonAscendant(int id)
        {
            DataLayer.Common current = new BusinessLayer.Common.Commons().GetByProperty(typeof(int), "Id", id.ToString()).FirstOrDefault();
            if (current.ParentId == null)
                return current;
            else
                return CommonAscendant((int)current.ParentId);
        }
        #endregion

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetProvinces(string knownCategoryValues, string category, string contextKey)
        {
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int), "ParentId", string.Empty);
            foreach (var item in q)
            {
                values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));
            }
            return values.ToArray();
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetCitiesForProvince(string knownCategoryValues, string category, string contextKey)
        {
            StringDictionary categoryValues = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            int ProvinceId = Convert.ToInt32(categoryValues["ProvinceId"]);
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int), "ParentId", ProvinceId.ToString());
            //.Where(e => e.ProvinceId == ProvinceID).OrderBy(e => e.Name).ToList();
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            foreach (var item in q)
            {
                values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));
            }
            return values.ToArray();
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetRegionsForCity(string knownCategoryValues, string category, string contextKey)
        {
            StringDictionary categoryValues = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            int CityId = Convert.ToInt32(categoryValues["CityId"]);
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int), "ParentId", CityId.ToString());
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            foreach (var item in q)
            {
                values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));
            }
            return values.ToArray();
        }
    }
}