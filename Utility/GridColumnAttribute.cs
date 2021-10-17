using System;

namespace Utility.DataAnnotation
{
    /// <summary>
    ///     Marks property as Grid.Mvc column, with specified parameters
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public class GridColumnAttribute : Attribute
    {

        public GridColumnAttribute()
        {
            //            EncodeEnabled = true;
            //          SanitizeEnabled = true;
            SortEnabled = false;
            VisibilityEnabled = false;
            FilterEnabled = false;
            SearchEnabled = false;
            HiddenEnabled = false;
        }

        /// <summary>
        ///     Sets or get the column title
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        ///     Enable or disable column searching
        /// </summary>
        public bool SearchEnabled { get; set; }

        /// <summary>
        ///     Enable or disable column sorting
        /// </summary>
        public bool SortEnabled { get; set; }

        /// <summary>
        ///     Enable or disable column filtering
        /// </summary>
        public bool FilterEnabled { get; set; }

        /// <summary>
        ///     Enable or disable column hiddenField
        /// </summary>
        public bool HiddenEnabled { get; set; }

        /// <summary>
        ///     Enable or disable column visibility
        /// </summary>
        public bool VisibilityEnabled { get; set; }

        /// <summary>
        ///     Sets or get column width,
        ///     Sample: "100px", "13%" ...
        /// </summary>
        public string Width { get; set; }

        /// <summary>
        ///     Sets or get column custom filter widget type
        /// </summary>
        public string FilterWidgetType { get; set; }
    }
}