// AdminCarsViewModel.cs
using CarSharingApp.Models;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System;
using System.Linq;

public class AdminCarsViewModel : BaseViewModel
{
    private readonly AppDbContext _context = new();

    public ObservableCollection<Car> Cars { get; } = new();
    public ObservableCollection<CarBrand> Brands { get; } = new();
    public ObservableCollection<CarType> Types { get; } = new();

    public ICommand AddCarCommand { get; }
    public ICommand EditCarCommand { get; }
    public ICommand DeleteCarCommand { get; }

    public AdminCarsViewModel()
    {
        LoadData();

        AddCarCommand = new RelayCommand(o => AddCar());
        EditCarCommand = new RelayCommand(o => EditCar(o as Car));
        DeleteCarCommand = new RelayCommand(o => DeleteCar(o as Car));
    }

    private void LoadData()
    {
        Cars.Clear();
        foreach (var car in _context.Cars.Include(c => c.Model))
            Cars.Add(car);

        Brands.Clear();
        foreach (var brand in _context.CarBrands)
            Brands.Add(brand);

        Types.Clear();
        foreach (var type in _context.CarTypes)
            Types.Add(type);
    }

    private void AddCar()
    {
        var dialog = new CarEditWindow();
        if (dialog.ShowDialog() == true && dialog.Car != null)
        {
            _context.Cars.Add(dialog.Car);
            _context.SaveChanges();
            Cars.Add(dialog.Car);
        }
    }

    private void EditCar(Car car)
    {
        if (car == null) return;
        
        var dialog = new CarEditWindow(car);
        if (dialog.ShowDialog() == true)
        {
            _context.SaveChanges();
            LoadData();
        }
    }
    
    private void DeleteCar(Car car)
    {
        if (car == null) return;
        
        if (MessageBox.Show("Вы уверены, что хотите удалить этот автомобиль?", 
                           "Подтверждение удаления", 
                           MessageBoxButton.YesNo) == MessageBoxResult.Yes)
        {
            _context.Cars.Remove(car);
            _context.SaveChanges();
            Cars.Remove(car);
        }
    }
}