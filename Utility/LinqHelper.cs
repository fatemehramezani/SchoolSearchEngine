using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Utility
{

    public class Filter
    {
        public string Property { get; set; }
        public object Value { get; set; }
    }

    public static class LinqHelper<TEntity>
        where TEntity : class, new()
    {
        public static Func<TEntity, bool> Build(IList<Filter> filters)
        {
            ParameterExpression param = Expression.Parameter(typeof (TEntity), "t");
            Expression exp = null;

            if (filters.Count == 1)
                exp = GetExpression(param, filters[0]);
            else if (filters.Count == 2)
                exp = GetExpression(param, filters[0], filters[1]);
            else
            {
                while (filters.Count > 0)
                {
                    var f1 = filters[0];
                    var f2 = filters[1];

                    if (exp == null)
                        exp = GetExpression(param, filters[0], filters[1]);
                    else
                        exp = Expression.AndAlso(exp, GetExpression(param, filters[0], filters[1]));

                    filters.Remove(f1);
                    filters.Remove(f2);

                    if (filters.Count == 1)
                    {
                        exp = Expression.AndAlso(exp, GetExpression(param, filters[0]));
                        filters.RemoveAt(0);
                    }
                }
            }

            return Expression.Lambda<Func<TEntity, bool>>(exp, param).Compile();
        }

        private static Expression GetExpression(ParameterExpression param, Filter filter)
        {
            try
            {
                MemberExpression member = Expression.Property(param, filter.Property);
                ConstantExpression constant = Expression.Constant(filter.Value);
                //Dynamic.InvokeConvert(obj, castTo, explict:true);
                //Convert.ChangeType(member, typeof());
                return Expression.Equal(member, constant);
            }
            catch (Exception ex)
            {
            }
            return null;
        }

        private static BinaryExpression GetExpression
            (ParameterExpression param, Filter filter1, Filter filter2)
        {
            Expression bin1 = GetExpression(param, filter1);
            Expression bin2 = GetExpression(param, filter2);

            return Expression.AndAlso(bin1, bin2);
        }

        public static List<PropertyInfo> GetForeignKey<TEntity>()
        {            
            List<PropertyInfo> ForeignKeyProperties = new List<PropertyInfo>();
            foreach (PropertyInfo propertyInfo in typeof(TEntity).GetProperties())
            {
                var foreignKeyAttribute = propertyInfo.GetCustomAttributes<ForeignKeyAttribute>().FirstOrDefault();
                if (foreignKeyAttribute != null)
                {
                    ForeignKeyProperties.Add(propertyInfo);
                }
            }
            return ForeignKeyProperties;
        }
      
        /// <summary>
        /// Changes the property 'propertyName' of object 'o' to 'newValue' if possible
        /// </summary>
        /// <param name="o">Object you wish to change the property value of</param>
        /// <param name="propertyName">property name to change (case sensitive)</param>
        /// <param name="newValue">new value of the property</param>
        public static void SetPropertyValue(this object o, string propertyName, object newValue)
        {
            PropertyInfo pi;
            pi = o.GetType().GetProperty(propertyName);
            if (pi == null)
                throw new Exception("No Property [" + propertyName + "] in Object [" + o.GetType().ToString() + "]");
            if (!pi.CanWrite)
                throw new Exception("Property [" + propertyName + "] in Object [" + o.GetType().ToString() + "] does not allow writes");
            pi.SetValue(o, newValue, null);
        }
    }
}
