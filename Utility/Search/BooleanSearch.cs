using System;
using System.ComponentModel.DataAnnotations;
using System.Linq.Expressions;

namespace Utility.Search
{
    public class BooleanSearch : AbstractSearch
    {
        public bool? SearchTerm { get; set; }

        public BooleanComparators Comparator { get; set; }

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
                case BooleanComparators.Equal:
                    return Expression.Equal(property, Expression.Constant(this.SearchTerm.Value));
                default:
                    throw new InvalidOperationException("Comparator not supported.");
            }
        }
    }

    public enum BooleanComparators
    {
        [Display(Name = "==")]
        Equal
    }
}
