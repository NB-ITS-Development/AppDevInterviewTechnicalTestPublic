namespace AppDevInterviewTechnicalTest.Models.Db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tickets.Lookup_Tag")]
    public partial class Lookup_Tag
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Lookup_Tag()
        {
            TicketsTagged = new HashSet<Ticket>();
        }

        [Key]
        [StringLength(50)]
        public string TagName { get; set; }

        public bool IsActive { get; set; }

        public string TagDescription { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Ticket> TicketsTagged { get; set; }
    }
}
