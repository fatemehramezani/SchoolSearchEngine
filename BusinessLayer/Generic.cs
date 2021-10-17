using System;
using DataLayer;
using RepositoryLayer;
using ViewModel;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Resources;
using Utility;
using Utility.Page;
using Utility.Search;
using Utility.DataAnnotation;

namespace BusinessLayer
{
    public abstract class Generic<T> where T : class, new()
    {
        protected readonly DatabaseEntities context;

        /*public FileResult Download(Guid streamId, string fileName)
        {
            byte[] fileBytes = FileStreamRepository.Download(streamId);
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }*/

        public virtual IQueryable<T> Get(ICollection<AbstractSearch> searchCriteria = null)
        {
            if (searchCriteria == null)
            {
                searchCriteria = typeof(T).GetDefaultSearchCriterias();
            }
            var entities = GenericRepository<T>
                .GetQuery()
                .ApplySearchCriterias(searchCriteria);
            return entities;
        }
        public virtual T GetFirst(Type propertyType, string property, string searchTerm)
        {
            return GetByProperty(propertyType, property, searchTerm).FirstOrDefault();
        }
        public virtual IQueryable<T> GetByProperty(Type propertyType, string property, string searchTerm)
        {
            ICollection<AbstractSearch> searchCriterias = new List<AbstractSearch>();
            #region bool
            if( propertyType == typeof(bool))
            {
                BooleanSearch searchCriteria = new BooleanSearch
                {
                    Property = property,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                    //Modeltyp
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = bool.Parse(searchTerm);
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            #region int
            else if (propertyType == typeof(int))
            {
                NumericSearch searchCriteria = new NumericSearch
                {
                    Property = property,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                    //Modeltyp
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = int.Parse(searchTerm);
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            #region string
            else if (propertyType == typeof(string))
            {
                TextSearch searchCriteria = new TextSearch
                {
                    Property = property,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                    //Modeltyp
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = searchTerm;
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            return Get(searchCriterias);
        }
        public virtual ICollection<AbstractSearch> SetSearchCriteria(ICollection<AbstractSearch> searchCriterias,Type propertyType, string property, string searchTerm)
        {
            #region bool
            if (propertyType == typeof(bool))
            {
                BooleanSearch searchCriteria = new BooleanSearch
                {
                    Property = property,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                    //Modeltyp
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = bool.Parse(searchTerm);
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            #region int
            else if (propertyType == typeof(int))
            {
                NumericSearch searchCriteria = new NumericSearch
                {
                    Property = property,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                    //Modeltyp
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = int.Parse(searchTerm);
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            #region string
            else if (propertyType == typeof(string))
            {
                TextSearch searchCriteria = new TextSearch
                {
                    Property = property,
                    Comparator = TextComparators.Contains,
                    TargetTypeName = $"DataLayer.DynamicPage, DataLayer, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
                };
                if (string.IsNullOrEmpty(searchTerm))
                    searchCriteria.SearchTerm = null;
                else
                    searchCriteria.SearchTerm = searchTerm;
                searchCriterias.Add(searchCriteria);
            }
            #endregion
            return searchCriterias;
        }
        public virtual PagedSearchViewModel<T> GetPaged(Paging paging, ICollection<AbstractSearch> searchCriteria)
        {
            if (searchCriteria == null)
            {
                searchCriteria = typeof(T).GetDefaultSearchCriterias();
            }
            var entities = GenericRepository<T>
                .GetQuery()
                .ApplySearchCriterias(searchCriteria)
                .GetPagedResult(paging);

            var model = new PagedSearchViewModel<T>()
            {
                Entities = entities,
                SearchCriteria = searchCriteria
            };
            return model;
        }

        public DropDownListViewModel DropDownList(string Name, long SelectedId = 0)
        {
            DropDownListViewModel model = new DropDownListViewModel
            {
                //Items = new SelectList(GenericRepository<T>.GetEnumerable(), "Id", "Title", SelectedId),
                FieldName = Name
            };
            return model;
        }

        public virtual T Details(int? id)
        {
            if (id == null)
            {
                return null;
            }
            return context.Set<T>().Find(id);
        }

        public virtual void Delete(T entity)
        {
            GenericRepository<T>.DeleteItem(entity);
        }

        public virtual void Delete(string Ids)
        {
           // var listId =
            //    Ids.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries)
            //        .Select(i => (int)i.ChangeType(typeof(int)));
            //foreach (var id in listId)
            //{
            //    GenericRepository<T>.DeleteItem(GenericRepository<T>.GetItemById(id));
            //}
        }

        public virtual void Add(T entity)
        {
           // GenericRepository<T>().Add(entity);
        }

        public virtual void Update(T entity)
        {
            //GenericRepository<T>().Update(entity);
        }

        //protected override void OnException(ExceptionContext filterContext)
        //{
        //    Exception exception = filterContext.Exception;
        //    filterContext.ExceptionHandled = true;
        //    var controllerName = (string)filterContext.RouteData.Values["controller"];
        //    var actionName = (string)filterContext.RouteData.Values["action"];
        //    var model = new HandleErrorInfo(filterContext.Exception, controllerName, actionName);

        //    filterContext.Result = new ViewResult
        //    {
        //        ViewName = "Home",
        //        ViewData = new ViewDataDictionary(model),
        //        TempData = filterContext.Controller.TempData
        //    };
        //}
    }
}