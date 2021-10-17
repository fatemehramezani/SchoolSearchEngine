using System.ComponentModel.DataAnnotations;
using System.Linq.Expressions;

namespace Utility.Search
{
    public class TextSearch : AbstractSearch
    {
        public string SearchTerm { get; set; }

        public TextComparators Comparator { get; set; }

        protected override Expression BuildExpression(MemberExpression property)
        {
            if (this.SearchTerm == null)
            {
                return null;
            }
            //if (this.Comparator == null)
            //{
            //    this.Comparator = TextComparators.Contains;
            //}
            var searchExpression = Expression.Call(
                property,
                typeof(string).GetMethod(this.Comparator.ToString(), new[] { typeof(string) }),
                Expression.Constant(this.SearchTerm));
            return searchExpression;
        }
    }

    public enum TextComparators
    {
        [Display(Name = "شامل")]
        Contains,
        [Display(Name = "برابر با")]
        Equals,
        [Display(Name = "شروع شود با")]
        StartsWith,
        [Display(Name = "پایان بپذیر با")]
        EndsWith,
    }
}
