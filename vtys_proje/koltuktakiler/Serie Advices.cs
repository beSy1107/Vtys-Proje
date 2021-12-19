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
    public partial class Serie_Advices : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Serie_Advices()
        {
            InitializeComponent();
        }
        bool isThere;
        private void byusr_button_Click(object sender, EventArgs e)
        {
            richTextBox3.Text = "";
            richTextBox3.Visible = true;
            panel2.Visible = false;

            //control moviename
            string seriename = name.Text;
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("Select seriename from series", connection);
            NpgsqlDataReader reader = control.ExecuteReader();

            while (reader.Read())
            {
                if (seriename == reader["seriename"].ToString())
                    isThere = true;
                else
                    isThere = false;
            }
            connection.Close();
            if (isThere == true)
            {
                connection.Open();
                NpgsqlCommand getinfo = new NpgsqlCommand("Select seriename,serietopic,catname,username from seriestable2 where seriename='" + seriename + "'", connection);
                NpgsqlDataReader readerinfo = getinfo.ExecuteReader();
                if (readerinfo.Read())
                {
                    richTextBox3.Text = "Serie' name : " + readerinfo["seriename"].ToString() + "\n \n Serie' Type : " + readerinfo["catname"] + "\n \n " + readerinfo["serietopic"] + "\n\n Writer : " + readerinfo["username"] + "\n \n";
                    isThere = (false);
                }
                connection.Close();
            }
            else { MessageBox.Show("Serie cannot found. Please, check the serie' name."); }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            richTextBox3.Visible = false;
            panel2.Visible = true;
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

        private void button7_Click(object sender, EventArgs e)
        {
            Login transition = new Login();
            transition.Show();
            this.Hide();
        }
        
        private void Serie_Advices_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from filmcategories", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            type_comboBox.DisplayMember = "catname";
            type_comboBox.ValueMember = "catid";

            type_comboBox.DataSource = dt;
            connection.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string catidd = type_comboBox.SelectedValue.ToString();
            int catid;
            Int32.TryParse(catidd, out catid);

            connection.Open();
            NpgsqlCommand getinfo = new NpgsqlCommand("Select seriename,serietopic,username from seriestable2 where catid=" + catid, connection);
            NpgsqlDataReader reader = getinfo.ExecuteReader();
            if (reader.Read())
            {
                richTextBox2.Text = "Serie name : " + reader["seriename"].ToString() + "\n \n" + reader["serietopic"].ToString() + "\n \n" + "Writer : " + reader["username"].ToString() + "\n" + "----------------------------------------" + "\n";
            }
            connection.Close();
        }
        int uuserid, serieid;
        int seriieid;
        private void button6_Click(object sender, EventArgs e)
        {
            richTextBox3.Text = "";
            richTextBox3.Visible = true;
            panel2.Visible = false;

            //control seriename
            string seriename = name.Text;
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("Select seriename,serieid from series", connection);
            NpgsqlDataReader reader = control.ExecuteReader();

            while (reader.Read())
            {
                if (seriename == reader["seriename"].ToString())
                {
                    isThere = true;
                    string serieidd = reader["serieid"].ToString();
                    Int32.TryParse(serieidd, out seriieid);
                    break;
                }
                else
                    isThere = false;
            }
            connection.Close();
            if (isThere == true)
            {
                connection.Open();
                NpgsqlCommand getinfo = new NpgsqlCommand("Select content,username from sreplies where serieid='" + seriieid + "'", connection);
                NpgsqlDataReader readerinfo = getinfo.ExecuteReader();
                if (readerinfo.Read())
                {
                    richTextBox3.Text = "Serie' name : " + name.Text + "\n \n Reply : " + readerinfo["content"] + "\n\n Writer : " + readerinfo["username"] + "\n \n";
                    isThere = (false);
                }
                connection.Close();
            }
            else { MessageBox.Show("Serie cannot found. Please, check the serie' name."); }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            Add_Serie transition = new Add_Serie();
            transition.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            connection.Open();



            NpgsqlCommand getinfo3 = new NpgsqlCommand("Select userid from users where username='" + Login.saveusername + "'", connection);
            NpgsqlDataReader reader3 = getinfo3.ExecuteReader();
            if (reader3.Read())
            {
                string useridd = reader3["userid"].ToString();
                Int32.TryParse(useridd, out uuserid);
                connection.Close();
                connection.Open();
                NpgsqlCommand getinfo2 = new NpgsqlCommand("Select serieid from series where seriename='" + textBox1.Text + "'", connection);
                NpgsqlDataReader reader2 = getinfo2.ExecuteReader();
                if (reader2.Read())
                {
                    string serieidd = reader2["serieid"].ToString();
                    Int32.TryParse(serieidd, out serieid);
                    connection.Close();
                    connection.Open();
                    NpgsqlCommand addnewsreply = new NpgsqlCommand("call sreply(" + serieid + "," + uuserid + ",'" + richTextBox1.Text + "')", connection);

                    addnewsreply.ExecuteNonQuery();

                    connection.Close();
                    MessageBox.Show("Your replies was added successfully");
                    richTextBox1.Text = "";
                    textBox1.Text = "";
                }
                else { MessageBox.Show("Serieid cannot found"); }
                connection.Close();
            }
            else { MessageBox.Show("Userid cannot found"); }
            connection.Close();

            


            
        }
    }
    
}
