using System.Windows;

namespace CarSharingApp
{
    public partial class ForgotPasswordWindow : Window
    {
        public ForgotPasswordWindow()
        {
            InitializeComponent();
        }

        private void SendCode_Click(object sender, RoutedEventArgs e)
        {
            var phone = txtPhone.Text.Trim();
            if (string.IsNullOrEmpty(phone))
            {
                MessageBox.Show("Введите номер телефона");
                return;
            }

            var verificationWindow = new VerificationWindow(phone);
            if (verificationWindow.ShowDialog() == true)
            {
                // Логика сброса пароля
                var newPasswordWindow = new NewPasswordWindow(phone);
                newPasswordWindow.ShowDialog();
                Close();
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e) => Close();
    }
}