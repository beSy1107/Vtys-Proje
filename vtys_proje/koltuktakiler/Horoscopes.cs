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
    public partial class Horoscopes : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Horoscopes()
        {
            InitializeComponent();
        }


        int a;
        int hid;
        private void search_button_Click(object sender, EventArgs e)
        {
            panel01.Visible = true;
            panel02.Visible = true;
            refresh.Visible = true;
            
            string hidd = comboBox1.SelectedValue.ToString();
            Int32.TryParse(hidd, out hid);

            connection.Open();
            NpgsqlCommand getfeature = new NpgsqlCommand("select * from horoscopefeatures where horoscopeid="+hid, connection);
            
            NpgsqlDataReader reader = getfeature.ExecuteReader();

            if (reader.Read())
            {
                richTextBox2.Text = reader["featurecontent"].ToString();
                richTextBox3.Text = "";
                connection.Close();
            }
            else MessageBox.Show("Error","Error");
            connection.Open();
            NpgsqlCommand getid = new NpgsqlCommand("select hreplieid from  hreplies where horoscopeid=" + hid + " order by hreplieid DESC limit 1", connection);
            NpgsqlDataReader reader3 = getid.ExecuteReader();
            if(reader3.Read())
            {
                string tutucu = reader3["hreplieid"].ToString();
                Int32.TryParse(tutucu, out a);
                
            }

            connection.Close();
            string tutt="";

            for (int i=a;i>=0;i--)
            {
                
                connection.Open();
                
                NpgsqlCommand getinfo = new NpgsqlCommand("select hrcontent,username from hreplies where horoscopeid=" + hid+" and hreplieid="+i, connection);
                NpgsqlDataReader reader2 = getinfo.ExecuteReader();
                if (reader2.Read())
                {
                    string tut = "Reply : " + reader2["hrcontent"].ToString() + "\n \nWriter : " + reader2["username"].ToString() + "\n \n"+"----------------------------------------" + "\n";

                    richTextBox3.Text = tutt + tut;
                    tutt = richTextBox3.Text;
                }
                connection.Close();
            }


            
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

        private void button3_Click(object sender, EventArgs e)
        {
            Questions transition = new Questions();
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

        private void Horoscopes_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from horoscopes", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            comboBox1.DisplayMember = "horoscopename";
            comboBox1.ValueMember = "horoscopeid";

            comboBox1.DataSource = dt;
            connection.Close();
        }
        
        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dataGridView2_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        int userid;
        private void button4_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand getuserid = new NpgsqlCommand("select userid from users where username='"+Login.saveusername+"'",connection);
            NpgsqlDataReader reader = getuserid.ExecuteReader();
            if(reader.Read())
            {
                string useridd = reader["userid"].ToString();
                Int32.TryParse(useridd, out userid);
            }
            else { MessageBox.Show("Cannot found userid","Error"); }

            connection.Close();

            connection.Open();
            string content = richTextBox1.Text.ToString();
            NpgsqlCommand addhreply = new NpgsqlCommand("call addnewhreply("+hid+",'"+content+"',"+userid+")",connection);
            addhreply.ExecuteNonQuery();
            connection.Close();
            MessageBox.Show("Added successfully.");
            richTextBox1.Text = "";
        }

        private void refresh_Click(object sender, EventArgs e)
        {
            string hidd = comboBox1.SelectedValue.ToString();
            Int32.TryParse(hidd, out hid);

            connection.Open();
            NpgsqlCommand getfeature = new NpgsqlCommand("select * from horoscopefeatures where horoscopeid=" + hid, connection);

            NpgsqlDataReader reader = getfeature.ExecuteReader();

            if (reader.Read())
            {
                richTextBox2.Text = reader["featurecontent"].ToString();
                richTextBox3.Text = "";
                connection.Close();
            }
            else MessageBox.Show("Error", "Error");
            connection.Open();
            NpgsqlCommand getid = new NpgsqlCommand("select hreplieid from  hreplies where horoscopeid=" + hid + " order by hreplieid DESC limit 1", connection);
            NpgsqlDataReader reader3 = getid.ExecuteReader();
            if (reader3.Read())
            {
                string tutucu = reader3["hreplieid"].ToString();
                Int32.TryParse(tutucu, out a);

            }else MessageBox.Show("Cannot found id=??", "Error");
            connection.Close();
            string tutt = "";

            for (int i = a; i >= 0; i--)
            {

                connection.Open();

                NpgsqlCommand getinfo = new NpgsqlCommand("select hrcontent,username from hreplies where horoscopeid=" + hid + " and hreplieid=" + i, connection);
                NpgsqlDataReader reader2 = getinfo.ExecuteReader();
                if (reader2.Read())
                {
                    string tut = "Reply : " + reader2["hrcontent"].ToString() + "\n \nWriter : " + reader2["username"].ToString() + "\n \n" + "----------------------------------------" + "\n";

                    richTextBox3.Text = tutt+tut;
                    tutt = richTextBox3.Text;
                }
                connection.Close();
            }
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            Main transition = new Main();
            transition.Show();
            this.Hide();
        }
    }
}
