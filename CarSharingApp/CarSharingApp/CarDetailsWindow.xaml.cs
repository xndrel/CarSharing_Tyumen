using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace CarSharingApp
{
    /// <summary>
    /// Логика взаимодействия для CarDetailsWindow.xaml
    /// </summary>
    public partial class CarDetailsWindow : Window
    {
        public CarDetailsWindow()
        {
            InitializeComponent();
        }

        private void RentButton_Click(object sender, RoutedEventArgs e)
        {
            // Логика аренды автомобиля
            MessageBox.Show("Функция аренды будет доступна в ближайшем обновлении");
        }
    }
}
