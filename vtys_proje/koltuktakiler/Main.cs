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
    public partial class Main : Form
    {
        //Veritabanı bağlantısının yapılışı
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Main()
        {
            InitializeComponent();
        }

        bool isThere; //kullanıcı kontrolü için
        public static string useridd;
       
        private void serachuser_button_Click(object sender, EventArgs e)
        {

            

                string username = search_user.Text;
                //Girilen username veritabanında kayıtlı mı? (kontrol)
                connection.Open();


                NpgsqlCommand controluser = new NpgsqlCommand("Select username,userid from users where username='" + username + "'", connection);
                NpgsqlDataReader reader = controluser.ExecuteReader();

                while (reader.Read())
                {
                    if (username == reader["username"].ToString())
                    {
                        isThere = true;
                        useridd = reader["userid"].ToString();

                        break;
                    }
                    else
                    {
                        isThere = false;


                    }



                }
                connection.Close();
            //Kontrol bitti

            int pointer;
            if (isThere == true)
                pointer = 1;
            else
                    pointer = 2;
            switch (pointer)
            {
                case 1:

                    connection.Open();


                    int userid = Int32.Parse(useridd);


                    NpgsqlCommand getinformation = new NpgsqlCommand("Select * from general where userid='" + userid + "'", connection);
                    NpgsqlDataReader reader2 = getinformation.ExecuteReader();
                    if (reader2.Read())
                    {

                        panel4.Visible = true;
                        panel5.Visible = true;
                        panel6.Visible = true;
                        panel7.Visible = true;
                        panel8.Visible = true;
                        panel9.Visible = true;

                        lblusername.Text = username;
                        lblmessages.Text = reader2["messages"].ToString();
                        lblquestions.Text = reader2["questions"].ToString();
                        lblreplies.Text = reader2["replies"].ToString();
                        lblhreplies.Text = reader2["hreplies"].ToString();
                        lblmreplies.Text = reader2["mreplies"].ToString();
                        lblsreplies.Text = reader2["sreplies"].ToString();
                        lblplaces.Text = reader2["places"].ToString();
                        lblmovies.Text = reader2["movies"].ToString();
                        lblseries.Text = reader2["series"].ToString();
                        lblname.Text = reader2["name"].ToString();
                        lblrank.Text = reader2["rankname"].ToString();
                        lblsurname.Text = reader2["surname"].ToString();
                        lblmssg.Text = "Succesfull!";
                        connection.Close();
                        isThere = false;
                    }
                    break;
                    
                case 2:


                    panel4.Visible = false;
                    panel5.Visible = false;
                    panel6.Visible = false;
                    panel7.Visible = false;
                    panel8.Visible = false;
                    panel9.Visible = false;


                    lblmssg.Text = "User could not found!";

                    break;
            }
            











        }
        //MENU KISMINDAKİ BUTONLARIN SAYFALARA YÖNLENDIRILMELERI
        private void button7_Click(object sender, EventArgs e)
        {
            Login transition = new Login();
            transition.Show();
            this.Hide();
        }

        private void myprofile_Click(object sender, EventArgs e)
        {
            My_Profile  transition = new My_Profile();
            transition.Show();
            this.Hide();
        }

        private void messages_Click(object sender, EventArgs e)
        {
            Messages transition = new Messages();
            transition.Show();
            this.Hide();
        }

        private void questions_Click(object sender, EventArgs e)
        {
            Questions transition = new Questions();
            transition.Show();
            this.Hide();
        }

        private void horoscopes_Click(object sender, EventArgs e)
        {
            Horoscopes transition = new Horoscopes();
            transition.Show();
            this.Hide();
        }

        private void trip_Click(object sender, EventArgs e)
        {
            Trip_Advices transition = new Trip_Advices();  
            transition.Show();
            this.Hide();
        }

        private void movie_Click(object sender, EventArgs e)
        {
            Movie_Advices transition = new Movie_Advices();
            transition.Show();
            this.Hide();
        }

       

        private void clear_button_Click(object sender, EventArgs e)
        {
            
            lblname.Text = "";
            lblrank.Text = "";
            lblsurname.Text = "";
            lblmssg.Text = "";
            lblusername.Text = "";
            lblmessages.Text = "";
            lblquestions.Text = "";
            lblreplies.Text = "";
            lblhreplies.Text = "";
            lblmreplies.Text = "";
            lblsreplies.Text = "";
            lblplaces.Text = "";
            lblmovies.Text = "";
            lblseries.Text = "";
        }

        private void Main_Load(object sender, EventArgs e)
        {

        }

        private void serie_Click_1(object sender, EventArgs e)
        {
            Serie_Advices transition = new Serie_Advices();
            transition.Show();
            this.Hide();
        }
    }
}
