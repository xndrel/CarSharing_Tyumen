using System.Windows;
using CarSharingApp.Helpers;
using CarSharingApp.Models;
using System.Linq;
using System.Windows.Input;
using System;

namespace CarSharingApp
{
    public partial class MainWindow : Window
    {
        private readonly AppDbContext _context = new AppDbContext();

        public MainWindow()
        {
            InitializeComponent();
            InitializeDefaultView();
        }

        // Инициализация начального вида
        private void InitializeDefaultView()
        {
            loginForm.Visibility = Visibility.Visible;
            registerForm.Visibility = Visibility.Collapsed;
        }

        // Переключение на форму входа
        private void SwitchToLogin(object sender, RoutedEventArgs e)
        {
            loginForm.Visibility = Visibility.Visible;
            registerForm.Visibility = Visibility.Collapsed;
        }

        // Переключение на форму регистрации
        private void SwitchToRegister(object sender, RoutedEventArgs e)
        {
            registerForm.Visibility = Visibility.Visible;
            loginForm.Visibility = Visibility.Collapsed;
        }

        // Обработка входа
        private void LoginBtn_Click(object sender, RoutedEventArgs e)
        {
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Password;

            if (string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Заполните все поля!");
                return;
            }

            var user = _context.Users.FirstOrDefault(u => u.Phone == phone);

            if (user == null || !PasswordHasher.VerifyPassword(password, user.PasswordHash))
            {
                MessageBox.Show("Неверный телефон или пароль!");
                return;
            }

            new UserWindow(user).Show();
            this.Close();
        }

        // Обработка регистрации
        private void RegisterBtn_Click(object sender, RoutedEventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string phone = txtRegPhone.Text.Trim();
            string email = txtRegEmail.Text.Trim();
            string password = txtRegPassword.Password;

            if (string.IsNullOrEmpty(fullName) ||
                string.IsNullOrEmpty(phone) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password))
            {
                MessageBox.Show("Заполните все поля!");
                return;
            }

            if (_context.Users.Any(u => u.Phone == phone))
            {
                MessageBox.Show("Этот телефон уже зарегистрирован!");
                return;
            }

            var newUser = new User
            {
                FullName = fullName,
                Phone = phone,
                Email = email,
                PasswordHash = PasswordHasher.HashPassword(password),
                RegistrationDate = DateTime.Now
            };

            _context.Users.Add(newUser);
            _context.SaveChanges();

            MessageBox.Show("Регистрация успешна!");
            SwitchToLogin(sender, e);
        }

        // Открытие окна восстановления пароля
        private void ForgotPassword_MouseDown(object sender, MouseButtonEventArgs e)
        {
            new ForgotPasswordWindow().ShowDialog();
        }
    }
}