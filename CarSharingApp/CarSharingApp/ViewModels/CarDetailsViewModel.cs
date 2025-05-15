using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using CarSharingApp.Models;
using CarSharingApp.Commands;

namespace CarSharingApp.ViewModels
{
    public class CarDetailsViewModel : BaseViewModel
    {
        private Car _car;
        
        public Car Car
        {
            get => _car;
            set 
            { 
                _car = value;
                OnPropertyChanged();
            }
        }
        
        public ICommand RentCommand { get; }
        
        public CarDetailsViewModel(Car car)
        {
            Car = car;
            RentCommand = new RelayCommand(o => RentCar());
        }
        
        private void RentCar()
        {
            // Логика аренды автомобиля
        }
    }
}
