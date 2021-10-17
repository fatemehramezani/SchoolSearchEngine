using System;
using System.ComponentModel.DataAnnotations;
using System.Linq.Expressions;

namespace Utility.Search
{
    public class ForeignKeySearch : AbstractSearch
    {
        public int? SearchTerm { get; set; }

        public ForeignKeyComparators Comparator { get; set; }

        protected override Expression BuildExpression(MemberExpression property)
        {
            if (!this.SearchTerm.HasValue)
            {
                return null;
            }

            Expression searchExpression = this.GetFilterExpression(property);

            return searchExpression;
        }

        private Expression GetFilterExpression(MemberExpression property)
        {
            switch (this.Comparator)
            {
                case ForeignKeyComparators.Equal:
                    return Expression.Equal(Expression.Convert(property, typeof(Int32)), Expression.Constant(this.SearchTerm.Value));
                default:
                    throw new InvalidOperationException("Comparator not supported.");
            }
        }
    }

    public enum ForeignKeyComparators
    {
        [Display(Name = "==")]
        Equal
    }
}
