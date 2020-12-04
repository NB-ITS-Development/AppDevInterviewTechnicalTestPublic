namespace AppDevInterviewTechnicalTest.Models.Db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tickets.Ticket")]
    public partial class Ticket
    {
        public int Id { get; set; }

        [Required]
        [StringLength(255)]
        public string Title { get; set; }

        [Display(Name = "Created At")]
        public DateTime DateTimeCreated { get; set; }

        [Display(Name = "Modified At")]
        public DateTime DateTimeModified { get; set; }

        [Display(Name = "Created By")]
        public int CreatedBy { get; set; }

        [Display(Name = "Modified By")]
        public int ModifiedBy { get; set; }

        [StringLength(50)]
        public string Tag { get; set; }

        [Required]
        public int Status { get; set; }

        public virtual Lookup_Tag TagData { get; set; }

        public virtual User CreatedByUser { get; set; }

        public virtual User ModifiedByUser { get; set; }

        public virtual Lookup_TicketStatus StatusData { get; set; }
    }
}
