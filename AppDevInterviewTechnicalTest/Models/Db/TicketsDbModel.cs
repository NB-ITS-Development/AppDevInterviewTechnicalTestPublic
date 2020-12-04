namespace AppDevInterviewTechnicalTest.Models.Db
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class TicketsDbModel : DbContext
    {
        public TicketsDbModel()
            : base("name=TicketsDb")
        {
        }

        public virtual DbSet<Lookup_Tag> Lookup_Tag { get; set; }
        public virtual DbSet<Ticket> Tickets { get; set; }
        public virtual DbSet<TicketNote> TicketNotes { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Lookup_Tag>()
                .HasMany(e => e.TicketsTagged)
                .WithOptional(e => e.TagData)
                .HasForeignKey(e => e.Tag)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Lookup_TicketStatus>()
                .HasMany(e => e.TicketsWithThisStatus)
                .WithRequired(e => e.StatusData)
                .HasForeignKey(e => e.Status)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.TicketsCreated)
                .WithRequired(e => e.CreatedByUser)
                .HasForeignKey(e => e.CreatedBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.TicketsModified)
                .WithRequired(e => e.ModifiedByUser)
                .HasForeignKey(e => e.CreatedBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.TicketNotesCreated)
                .WithRequired(e => e.CreatedByUser)
                .HasForeignKey(e => e.CreatedBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.TicketNotesModified)
                .WithRequired(e => e.ModifiedByUser)
                .HasForeignKey(e => e.ModifiedBy)
                .WillCascadeOnDelete(false);
        }
    }
}
