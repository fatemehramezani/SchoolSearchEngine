using Utility.Page;
using Utility.Search;
using System.Collections.Generic;

namespace ViewModel
{
    public class PagedSearchViewModel<T> where T : class
    {
        public PagedResult<T> Entities { get; set; }

        public IEnumerable<AbstractSearch> SearchCriteria { get; set; }
    }
}