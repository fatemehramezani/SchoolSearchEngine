using Utility.Search;
using System.Collections.Generic;

namespace ViewModel
{
    public class SearchViewModel<T> where T : class
    {
        public IEnumerable<T> Entities { get; set; }

        public IEnumerable<AbstractSearch> SearchCriteria { get; set; }
    }
}