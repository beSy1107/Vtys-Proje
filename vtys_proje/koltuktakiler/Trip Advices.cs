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
    public partial class Trip_Advices : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Trip_Advices()
        {
            InitializeComponent();
        }

        private void myprofile_Click(object sender, EventArgs e)
        {
            My_Profile transition = new My_Profile();
            transition.Show();
            this.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Messages transition = new Messages();
            transition.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
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

        private void movie_Click(object sender, EventArgs e)
        {
            Movie_Advices transition = new Movie_Advices();
            transition.Show();
            this.Hide();
        }

        private void serie_Click(object sender, EventArgs e)
        {
            Serie_Advices transition = new Serie_Advices();
            transition.Show();
            this.Hide();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            Login transition = new Login();
            transition.Show();
            this.Hide();
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            Main transition = new Main();
            transition.Show();
            this.Hide();
        }
        int coc,cic,pd;

        private void button4_Click(object sender, EventArgs e)
        {
            button3.Visible=true;
            string cicc = comboBox2.SelectedValue.ToString();
            Int32.TryParse(cicc, out cic);

            connection.Open();

            NpgsqlCommand getcombo2 = new NpgsqlCommand("select * from places where countrycode=" + coc + " and citycode=" + cic, connection);
            NpgsqlDataAdapter da2 = new NpgsqlDataAdapter(getcombo2);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            comboBox3.DisplayMember = "placename";
            comboBox3.ValueMember = "placeid";

            comboBox3.DataSource = dt2;

            connection.Close();
            string pdd = comboBox3.SelectedValue.ToString();
            Int32.TryParse(pdd, out pd);
        }

        private void ok1_Click(object sender, EventArgs e)
        {
            button4.Visible = true;
            string cocc = comboBox1.SelectedValue.ToString();
            Int32.TryParse(cocc, out coc);
            connection.Open();

            NpgsqlCommand getcombo1 = new NpgsqlCommand("select * from cities where countrycode=" + coc, connection);
            NpgsqlDataAdapter da1 = new NpgsqlDataAdapter(getcombo1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            comboBox2.DisplayMember = "cityname";
            comboBox2.ValueMember = "citycode";

            comboBox2.DataSource = dt1;

            connection.Close();

        }
        string countryname, cityname;

        private void addplace_Click(object sender, EventArgs e)
        {
            Advice_New_Place transition = new Advice_New_Place();
            transition.Show();
        }

        private void bypname_button_Click(object sender, EventArgs e)
        {
            string placename=pname.Text;

            connection.Open();

            NpgsqlCommand getinfo = new NpgsqlCommand("select * from placess where placename='"+placename+"'",connection);
            NpgsqlDataReader reader = getinfo.ExecuteReader();

            if (reader.Read())
            {

                string username = reader["username"].ToString();
                string content = reader["content"].ToString();
                string citycode = reader["citycode"].ToString();
                string countrycode = reader["countrycode"].ToString();
                int citycde, countrycde;
                Int32.TryParse(citycode, out citycde);
                Int32.TryParse(countrycode, out countrycde);
                connection.Close();
                connection.Open();
                NpgsqlCommand getcityname = new NpgsqlCommand("select cityname from cities where citycode=" + citycde, connection);
                NpgsqlDataReader reader2 = getcityname.ExecuteReader();
                if (reader2.Read())
                {
                    cityname = reader2["cityname"].ToString();
                    connection.Close();
                }
                else MessageBox.Show("Cannot found City Name");
                connection.Open();
                NpgsqlCommand getcountryname = new NpgsqlCommand("select countryname from countries where countrycode=" + countrycde, connection);
                NpgsqlDataReader reader3 = getcountryname.ExecuteReader();
                if (reader3.Read())
                {
                    countryname = reader3["countryname"].ToString();
                    connection.Close();
                }
                else MessageBox.Show("Cannot found City Name");

                richTextBox2.Text = "\n" + placename + "\n\n" + "Country : " + countryname + "\nCity : " + cityname + "\n\n" + content + "\n\nWriter : " + username;
            }
            else
            {
                MessageBox.Show("Cannot Found");
                connection.Close();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand getplace = new NpgsqlCommand("select content,username from placess where placeid="+pd,connection);
            NpgsqlDataReader reader = getplace.ExecuteReader();
            if (reader.Read())
            {
                richTextBox1.Text="\n"+reader["content"].ToString()+"\n\n"+"Writer : "+reader["username"].ToString();
                connection.Close();
            }
            else MessageBox.Show("Error","Error");
        }

        private void Trip_Advices_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand getcombo = new NpgsqlCommand("select * from countries", connection);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(getcombo);
            DataTable dt = new DataTable();
            da.Fill(dt);
            comboBox1.DisplayMember = "countryname";
            comboBox1.ValueMember = "countrycode";

            comboBox1.DataSource = dt;
            connection.Close();
            
            

        }
    }
}
