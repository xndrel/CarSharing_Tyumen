using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;
using System;
using System.Linq;

public class BaseViewModel : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;
    protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
}

// В Services/NavigationService.cs
public class NavigationService
{
    private readonly Dictionary<string, Func<Window>> _windows;
    public NavigationService() => _windows = new Dictionary<string, Func<Window>>();
    public void RegisterWindow(string key, Func<Window> createWindow) => _windows[key] = createWindow;
    public void ShowWindow(string key) => _windows[key]().Show();
    public void CloseWindow(string windowName) => Application.Current.Windows.OfType<Window>()
        .FirstOrDefault(w => w.Name == windowName)?.Close();
}