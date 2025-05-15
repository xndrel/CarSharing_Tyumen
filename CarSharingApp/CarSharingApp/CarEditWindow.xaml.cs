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
using CarSharingApp.Models;

namespace CarSharingApp
{
    /// <summary>
    /// Логика взаимодействия для CarEditWindow.xaml
    /// </summary>
    public partial class CarEditWindow : Window
    {
        public Car Car { get; private set; }

        public CarEditWindow()
        {
            InitializeComponent();
            Car = new Car();
            DataContext = Car;
        }

        public CarEditWindow(Car car)
        {
            InitializeComponent();
            Car = car;
            DataContext = Car;
        }
    }
}
