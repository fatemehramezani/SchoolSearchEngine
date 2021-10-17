using System.Runtime.Serialization;

namespace Utility.Page
{
    [DataContract]
    public enum SortDirection
    {
        [EnumMember]
        Ascending,

        [EnumMember]
        Descending
    }
}
