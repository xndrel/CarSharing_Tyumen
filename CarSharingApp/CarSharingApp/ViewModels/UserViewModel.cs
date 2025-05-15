// UserViewModel.cs
using CarSharingApp.Models;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System;
using System.Linq;
using System.Windows;

public class UserViewModel : BaseViewModel
{
    private readonly AppDbContext _context;
    private readonly User _currentUser;

    public ObservableCollection<Car> Cars { get; } = new();
    public ObservableCollection<CarType> CarTypes { get; } = new();

    public ICommand SelectCarCommand { get; }
    public ICommand OpenSupportChatCommand { get; }

    public UserViewModel(User user)
    {
        _currentUser = user;
        _context = new AppDbContext();

        LoadData();

        SelectCarCommand = new RelayCommand(o => OnCarSelected(o as Car));
        OpenSupportChatCommand = new RelayCommand(o => OpenSupportChat());
    }

    private void LoadData()
    {
        var cars = _context.Cars
            .Include(c => c.Model)
            .ThenInclude(m => m.Brand)
            .Where(c => c.IsAvailable)
            .ToList();

        Cars.Clear();
        foreach (var car in cars) Cars.Add(car);

        CarTypes.Clear();
        CarTypes.Add(new CarType { TypeName = "Все" });
        foreach (var type in _context.CarTypes.ToList())
            CarTypes.Add(type);
    }

    private void OnCarSelected(Car car)
    {
        if (car == null) return;
        
        var dialog = new CarDetailsWindow();
        dialog.DataContext = car;
        if (dialog.ShowDialog() == true)
        {
            // Обработка аренды
        }
    }

    private void OpenSupportChat()
    {
        var supportWindow = new SupportWindow();
        supportWindow.DataContext = _currentUser;
        supportWindow.Show();
    }
}