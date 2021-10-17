using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utility.Search;
namespace BusinessLayer.Common
{
    public partial class DynamicPages:Generic<DataLayer.DynamicPage>
    {
        /*      Criterias = {
        searchCriteria: [{
            SearchTerm: $("#selectedGroupId").val(),
            Property: "GroupId",
            TargetTypeName: "Goldoon.Models.Group." + name + ", Goldoon.Models, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
            ModelTypeName: "ELearning.Utility.Search.ForeignKeySearch, ELearning.Utility, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
        }
        ,
        {
            Property: "Group.Title",
            TargetTypeName: "Goldoon.Models.Group." + name + ", Goldoon.Models, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null",
            ModelTypeName: "ELearning.Utility.Search.TextSearch, ELearning.Utility, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
        }
        ]
    }; 
        Utility.Search.AbstractSearch s = new Utility.Search.AbstractSearch
        {
        }*/
        //public virtual IQueryable<DataLayer.DynamicPage> GetByIsVisible()
        //{
        //    AbstractSearch searchCriteria = new AbstractSearch();
        //    searchCriteria.Property = "IsVisible";
        //    searchCriteria.TargetTypeName = "DataLayer.DynamicPages";
        //    IQueryable<AbstractSearch> searchCriterias = new IQueryable<AbstractSearch>
        //    {
        //        searchCriteria
        //    }
        //    return Get(searchCriterias);
        //}
    }
}
