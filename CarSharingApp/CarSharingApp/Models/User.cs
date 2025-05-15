using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSharingApp.Models
{
    [Table("Users")]
    public class User
    {
        [Key]
        public int UserID { get; set; }

        [Required(ErrorMessage = "ФИО обязательно")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "ФИО от 3 до 100 символов")]
        public string FullName { get; set; }

        [Required(ErrorMessage = "Телефон обязателен")]
        [RegularExpression(@"^\+7\d{10}$", ErrorMessage = "Формат: +7XXXXXXXXXX")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Email обязателен")]
        [EmailAddress(ErrorMessage = "Некорректный email")]
        public string Email { get; set; }

        [Required, MaxLength(255)]
        public string PasswordHash { get; set; }

        [Required]
        public DateTime RegistrationDate { get; set; }

        public DateTime? LastLoginDate { get; set; }

        [Required]
        public bool IsBlocked { get; set; }

        [Required]
        public bool IsAdmin { get; set; }

        [Required]
        public bool IsSupport { get; set; }

        // Навигационные свойства
        public virtual ICollection<Rental> Rentals { get; set; }
        public virtual ICollection<SupportChat> SupportChats { get; set; }
        public virtual ICollection<Message> Messages { get; set; }
        public virtual ICollection<Announcement> Announcements { get; set; }
    }
}