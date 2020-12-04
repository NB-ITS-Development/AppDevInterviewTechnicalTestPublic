using System.ComponentModel.DataAnnotations;

namespace AppDevInterviewTechnicalTest.Models
{
    public class LoginModel
    {

        [Required]
        public string Username { get; set; }

    }
}