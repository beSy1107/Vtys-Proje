using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace koltuktakiler
{
    public partial class Login : Form
    {
        //Veritabanı bağlantısının yapılışı
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");

        public Login()
        {
            InitializeComponent();
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        bool isNotThere; //sign in için yok mu kontrol değişkenim

        private void sign_button_Click(object sender, EventArgs e)
        {
            //Girilen username veritabanında kayıtlı mı? (kontrol)
            connection.Open();
            
            string username = sign_username.Text;


            NpgsqlCommand controlnewuser = new NpgsqlCommand("Select username from users", connection);
            NpgsqlDataReader reader = controlnewuser.ExecuteReader();

            while (reader.Read())
            {
                if (username == reader["username"].ToString())
                {
                    isNotThere = false;
                    break;
                }
                else
                {
                    isNotThere = true;

                }



            }
            connection.Close();
            //Kontrol bitti


            
            if (isNotThere == true)
            {

                connection.Open();
                //"yok mu" sorgumuz doğruysa ekleme işlemi yapıcak
                NpgsqlCommand addnewuser = new NpgsqlCommand("call addnewuser(@username,@password,@name,@surname)", connection);

                addnewuser.Parameters.AddWithValue("@username", sign_username.Text.ToString());
                addnewuser.Parameters.AddWithValue("@password", sign_password.Text.ToString());
                addnewuser.Parameters.AddWithValue("@name", sign_name.Text.ToString());
                addnewuser.Parameters.AddWithValue("@surname", sign_surname.Text.ToString());

                addnewuser.ExecuteNonQuery();

                connection.Close();

                MessageBox.Show("Registration succesfull. You can login.", "Successful!");

                //kayıt işlemi başarıyla tamamlanırsa textbox'ların içini boşaltıcam
                sign_username.Text = "";
                sign_surname.Text = "";
                sign_name.Text = "";
                sign_password.Text = "";


            }
            if (isNotThere == false)
            {
                //yok mu sorgumuz yanlışsa hata vericek
                MessageBox.Show("Username is already registered.", "Error!");

            }

           

        }

        public static string saveusername; //giriş işleminden sonra bu değişkende saklıyorum

        bool isThere; //login için var mı kontrol değişkenim

        private void log_button_Click(object sender, EventArgs e)
        {

            //Girilen username veritabanında kayıtlı mı? (kontrol)
            connection.Open();

            saveusername = log_username.Text;
            string password = log_password.Text;


            NpgsqlCommand controluser = new NpgsqlCommand("Select username,password from users", connection);
            NpgsqlDataReader reader = controluser.ExecuteReader();

            while (reader.Read())
            {
                if (saveusername == reader["username"].ToString() && password == reader["password"].ToString())
                {
                    isThere = true;
                    break;
                }
                else
                {
                    isThere = false;

                }



            }
            connection.Close();
            //Kontrol bitti


            if (isThere == true)
            {
                

                MessageBox.Show("Your login is succesfull. Welcome koltuktaki.", "Successful!");
                Main transition = new Main();
                transition.Show();
                this.Hide();


            }
            if (isThere == false)
            {
                //var mı sorgumuz yanlışsa hata vericek
                MessageBox.Show("Username is not exist.", "Error!");

            }

        }
    }
}
