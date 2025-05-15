using System.Windows;
using CarSharingApp.Models;

namespace CarSharingApp
{
    public partial class SupportWindow : Window
    {
        private readonly User _user;

        public SupportWindow(User user)
        {
            InitializeComponent();
            _user = user;
            Title = $"Поддержка - {_user.FullName}";
            LoadMessages();
        }

        private void LoadMessages()
        {
            // Загрузка истории сообщений
            MessagesListView.ItemsSource = new[]
            {
                new { Text = "Пример сообщения поддержки", Sender = "Оператор" },
                new { Text = "Пример ответа пользователя", Sender = _user.FullName }
            };
        }

        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtMessage.Text))
            {
                // Логика отправки сообщения
                MessageBox.Show("Сообщение отправлено!");
                txtMessage.Clear();
            }
        }
    }
}