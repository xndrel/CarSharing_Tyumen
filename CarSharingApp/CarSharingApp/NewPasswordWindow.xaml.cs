using System.Windows;
using System.Linq;
using CarSharingApp.Models;
using CarSharingApp.Helpers;

namespace CarSharingApp
{
    public partial class NewPasswordWindow : Window
    {
        private readonly string _phone;

        public NewPasswordWindow(string phone)
        {
            InitializeComponent();
            _phone = phone;
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            if (newPasswordBox.Password != confirmPasswordBox.Password)
            {
                MessageBox.Show("Пароли не совпадают");
                return;
            }

            using (var context = new AppDbContext())
            {
                var user = context.Users.FirstOrDefault(u => u.Phone == _phone);
                if (user != null)
                {
                    // Используем новый класс для хэширования
                    user.PasswordHash = PasswordHelper.HashPassword(newPasswordBox.Password);
                    context.SaveChanges();
                    MessageBox.Show("Пароль успешно изменен!");
                    Close();
                }
                else
                {
                    MessageBox.Show("Пользователь не найден");
                }
            }
        }
    }
}