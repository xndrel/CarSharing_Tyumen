using System.Windows;
using System.Windows.Input;
using System.Threading.Tasks;
using MaterialDesignThemes.Wpf;
using System;

namespace CarSharingApp
{
    public partial class VerificationWindow : Window
    {
        private string _generatedCode;
        private int _remainingSeconds = 120;

        public VerificationWindow(string phoneNumber)
        {
            InitializeComponent();
            DataContext = this;
            _generatedCode = new Random().Next(1000, 9999).ToString();
            SendSmsSimulation(phoneNumber);
            StartTimer();
        }

        private void SendSmsSimulation(string phone)
        {
            MessageBox.Show($"На номер {phone} отправлен код: {_generatedCode}",
                          "Тест SMS",
                          MessageBoxButton.OK,
                          MessageBoxImage.Information);
        }

        private async void StartTimer()
        {
            while (_remainingSeconds > 0)
            {
                TimerText = $"Повторная отправка через {_remainingSeconds} сек.";
                await Task.Delay(1000);
                _remainingSeconds--;
            }
            TimerText = "Запросить код повторно";
        }

        public string TimerText
        {
            get { return (string)GetValue(TimerTextProperty); }
            set { SetValue(TimerTextProperty, value); }
        }

        public static readonly DependencyProperty TimerTextProperty =
            DependencyProperty.Register("TimerText", typeof(string), typeof(VerificationWindow));

        private void VerifyButton_Click(object sender, RoutedEventArgs e)
        {
            if (txtCode.Text == _generatedCode)
            {
                DialogResult = true;
                Close();
            }
            else
            {
                MessageBox.Show("Неверный код подтверждения",
                              "Ошибка",
                              MessageBoxButton.OK,
                              MessageBoxImage.Error);
            }
        }

        public ICommand VerifyCommand => new RelayCommand(_ =>
        {
            if (txtCode.Text == _generatedCode)
            {
                DialogResult = true;
                Close();
            }
            else
            {
                MessageBox.Show("Неверный код подтверждения",
                              "Ошибка",
                              MessageBoxButton.OK,
                              MessageBoxImage.Error);
            }
        });
    }
}