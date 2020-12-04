namespace AppDevInterviewTechnicalTest.Models.Db
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tickets.Lookup_TicketStatus")]
    public partial class Lookup_TicketStatus
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Lookup_TicketStatus()
        {
            TicketsWithThisStatus = new HashSet<Ticket>();
        }

        [Key]
        public int Id { get; set; }

        [StringLength(255)]
        public string Title { get; set; }

        public bool IsActive { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Ticket> TicketsWithThisStatus { get; set; }
    }
}
