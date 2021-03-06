//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataLayer
{
    using System;
    using System.Collections.Generic;
    
    public partial class Teacher
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Description { get; set; }
        public Nullable<int> SchoolId { get; set; }
        public string Role { get; set; }
        public string AvatarUrl { get; set; }
        public string ResumeUrl { get; set; }
        public Nullable<int> ApplicantId { get; set; }
    
        public virtual Information Information { get; set; }
        public virtual Applicant Applicant { get; set; }
    }
}
