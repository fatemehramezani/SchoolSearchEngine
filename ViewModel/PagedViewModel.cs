using Utility.Page;
using System.Collections.Generic;

namespace ViewModel
{
    public class PagedViewModel<T> where T : class
    {
        public PagedResult<T> Entities { get; set; }
    }
}