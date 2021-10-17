using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web.UI.WebControls;
using Utility;
using DataLayer;

namespace RepositoryLayer
{
    //Please create another Project for these type of file
    public static class Repository<T> where T : class
    {
        //TODO: In this code use "using(var entities = new ApplicationDbContext())" it had an error beacause dispose DBContext and we need it
        //I create entities in Constructor, Fatemeh Ramezani
        private static DatabaseEntities entities;
        static Repository()
        {
            entities = new DatabaseEntities();
        }
        public static IQueryable<T> GetQuery()
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IQueryable<T> result = entities.Set<T>();
            var query = result.AsQueryable();
            return query;
            //}
        }

        public static IEnumerable<T> GetEnumerable()
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IEnumerable<T> result = entities.Set<T>();
            var query = result.AsEnumerable();
            return query;
            //}
        }

        public static IEnumerable<T> GetList(Func<T, bool> predicate = null, string sortExpression = null, SortDirection sortDirection = SortDirection.Ascending)
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IQueryable<T> result = entities.Set<T>();
            if (!string.IsNullOrEmpty(sortExpression))
                result = result.OrderBy(sortExpression + " " + sortDirection);
            return (predicate == null ? result : result.Where(predicate)).ToList();
            //}
        }

        public static IEnumerable<T> GetListExtended(Func<T, bool> predicate = null, string sortExpression = null, SortDirection sortDirection = SortDirection.Ascending, string[] includes = null)
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IQueryable<T> result = entities.Set<T>();
            if (includes != null)
                includes.ForEach(i => result = result.Include(i));
            if (!string.IsNullOrEmpty(sortExpression))
                result = result.OrderBy(sortExpression + " " + sortDirection);
            return (predicate == null ? result : result.Where(predicate)).ToList();
            //}
        }

        public static IEnumerable<T> GetTreeExtended(Func<T, bool> predicate = null, string sortExpression = null, SortDirection sortDirection = SortDirection.Ascending)
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IQueryable<T> result = entities.Set<T>();
            result = result.Include((typeof(T)).Name);
            if (!string.IsNullOrEmpty(sortExpression))
                result = result.OrderBy(sortExpression + " " + sortDirection);
            return (predicate == null ? result : result.Where(predicate)).ToList();
            //}
        }

        public static IEnumerable<TResult> GetSelectiveList<TResult>(Func<T, TResult> selector, Func<T, bool> predicate = null)
        {
            //using (var entities = new ApplicationDbContext())
            return (predicate == null ? entities.Set<T>() : entities.Set<T>().Where(predicate)).Select(selector).ToList();
        }

        public static IEnumerable<TResult> GetSelectiveList<TResult>(Func<T, TResult> selector, string predicate, string sortExpression = null, SortDirection sortDirection = SortDirection.Ascending)
        {
            //using (var entities = new ApplicationDbContext())
            //{
            IQueryable<T> result = entities.Set<T>();
            if (!string.IsNullOrEmpty(sortExpression))
                result = result.OrderBy(sortExpression + " " + sortDirection);
            return (predicate == null ? result : result.Where(predicate)).Select(selector).ToList();
            //}
        }

        public static T GetItemById(long id)
        {
            //using (var entities = new ApplicationDbContext())
            return entities.Set<T>().Find(id);
        }

        public static T GetLast(Func<T, bool> predicate = null)
        {
            //using (var entities = new ApplicationDbContext())
            return (predicate == null ? entities.Set<T>().OrderBy("Id") : entities.Set<T>().OrderBy("Id").Where(predicate)).LastOrDefault();
        }

        public static T SaveItem(T item, System.Data.Entity.EntityState state)
        {
            if (state == System.Data.Entity.EntityState.Modified || state == System.Data.Entity.EntityState.Added)
                GeneralValidation(item);
            //using (var entities = new ApplicationDbContext())
            //{
            entities.Entry(item).State = state;
            entities.SaveChanges();
            //}
            return item;
        }

        private static void GeneralValidation(T item)
        {
            item.GetPropertiesInfo().Where(i => i.PropertyType == typeof(string)).ForEach(i =>
            {
                object value = item.GetProperty(i.Name);
                if (value != null)
                    item.SetProperty(i.Name, Extentions.RemoveArabicEncoding((string)value));
            });
        }

        public static T InsertItem(T item)
        {
            GeneralValidation(item);
            entities.Set<T>().Add(item);
            entities.SaveChanges();
            return item;
        }

        public static T UpdateItem(T item)
        {
            GeneralValidation(item);
            entities.Set<T>().AddOrUpdate(item);
            entities.SaveChanges();
            return item;
        }

        public static T DeleteItem(T item)
        {
            GeneralValidation(item);
            entities.Set<T>().Remove(item);
            entities.SaveChanges();
            return item;

        }
    }
}
