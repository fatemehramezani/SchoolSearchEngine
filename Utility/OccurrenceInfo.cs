using System;

namespace Utility
{
    public class OccurrenceInfo
    {
        private DateTime start;
        private DateTime end;

        public OccurrenceInfo(DateTime start, DateTime end)
        {
            this.start = start;
            this.end = end;
        }

        public DateTime Start
        {
            get { return start; }
            set { start = value; }
        }

        public DateTime End
        {
            get { return end; }
            set { end = value; }
        }
    }
}