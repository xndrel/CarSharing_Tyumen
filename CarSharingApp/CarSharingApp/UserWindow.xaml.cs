using System.Windows;
using System.Data.Entity;
using CarSharingApp.Models;

namespace CarSharingApp
{
    public partial class UserWindow : Window
    {
        private readonly AppDbContext _context = new AppDbContext();
        private readonly User _currentUser;

        public UserWindow(User user)
        {
            InitializeComponent();
            _currentUser = user;
            LoadData();
        }

        private void LoadData()
        {
            // Загрузка автомобилей с связанными данными
            _context.Cars
                .Include(c => c.Model.Brand)
                .Include(c => c.Model.Type)
                .Load();

            CarsListView.ItemsSource = _context.Cars.Local;
            RentalStatusText.Text = _currentUser.IsBlocked
                ? "Статус: Заблокирован"
                : "Статус: Активен";
        }

        private void SupportButton_Click(object sender, RoutedEventArgs e)
        {
            new SupportWindow(_currentUser).ShowDialog();
        }

        private void LogoutButton_Click(object sender, RoutedEventArgs e)
        {
            new MainWindow().Show();
            this.Close();
        }

        private void ProfileButton_Click(object sender, RoutedEventArgs e)
        {
            // Логика открытия профиля
        }
    }
}