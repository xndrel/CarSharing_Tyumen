using System.Data.Entity;

namespace CarSharingApp.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext() : base("name=CarSharingDb")
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<CarType> CarTypes { get; set; }
        public DbSet<CarBrand> CarBrands { get; set; }
        public DbSet<CarModel> CarModels { get; set; }
        public DbSet<Car> Cars { get; set; }
        public DbSet<Rental> Rentals { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<SupportChat> SupportChats { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<Announcement> Announcements { get; set; }
    }
}