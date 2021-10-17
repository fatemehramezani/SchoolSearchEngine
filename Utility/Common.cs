using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Text.RegularExpressions;

namespace Utility
{
    public partial class Common
    {
        public const string SchoolId = "schoolid";
        public const string SchoolName = "schoolname";

        public const string BlogId = "blogid";
        public const string BlogTitle = "blogtitle";

        public const string NewsId = "newsid";
        public const string NewsTitle = "newstitle";

        public const string TeacherId = "teacherid";
        public const string TeacherTitle = "teachertitle";

        public const string StudentId = "studentid";
        public const string StudentTitle = "studenttitle";

        public const string PhotoCategoryId = "photocategoryid";
        public const string PhotoCategoryTitle = "photocategorytitle";        

        public const string Title = "title";
        public const string Keyword = "keyword";
        public const string Description = "description";

        public const string FilterType = "filtertype";
        public const string FilterValue = "filtervalue";
        public const string Filters = "filters";

        public const string BlogImageUrl = "BlogImageUrl";
        public const string BlogFileUrl = "BlogFileUrl";

        public const string NewsImageUrl = "NewsImageUrl";
        public const string NewsFileUrl = "NewsFileUrl";

        public const string TeacherAvatarUrl = "TeacherAvatarUrl";
        public const string TeacherResumeUrl = "TeacherResumeUrl";

        public const string StudentAvatarUrl = "StudentAvatarUrl";

        public const string PhotoCategoryUrl = "PhotoCategoryUrl";

        public const string SchoolLogoUrl = "SchoolLogoUrl";
        public const string SchoolBannerUrl = "SchoolBannerUrl";

        public static string GetConfigValue(string value)
        {
            return ConfigurationManager.AppSettings[value].ToString();
        }
        #region Word Frequency
        public static string WordHighFrequency(string values)
        {
            Dictionary<string, int> words = new Dictionary<string, int>();

            var spliteChar = new Char[] { ',', '،', '-', '_', '.', ' ', '\n', '\r' };
            values.Replace("(", "").Replace(")", "").Replace("(", "").Replace("'", "").Replace(@"""", "");
            string[] valueList = values.Split(spliteChar, StringSplitOptions.RemoveEmptyEntries).Where(s=>s.Length > 3).ToArray();

            var groups = valueList.GroupBy(item => item);
            foreach (var group in groups)
                words.Add(group.Key,group.Count());
            return words.OrderByDescending(w => w.Value).Select(w => w.Key).Aggregate((i, j) => i + "،" + j);
        }
        #endregion
    }

    public enum BasicCommon
    {
        Type = 1, //نوع مدرسه
        Gender = 2,//دخترانه/پسرانه
        Section = 3,//مقطع آموزشی        
        Branch = 27,//شاخه تحصیلی
        Level = 45//پایه تحصیلی
    }
}
