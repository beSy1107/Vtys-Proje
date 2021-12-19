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
    public partial class Movie_Advices : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Movie_Advices()
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
            string moviename = name.Text;
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("Select moviename from movies" , connection);
            NpgsqlDataReader reader = control.ExecuteReader();

            while (reader.Read())
            {
                if(moviename==reader["moviename"].ToString())
                    isThere = true;
                else
                    isThere=false;
            }connection.Close();
            if(isThere==true)
            {
                connection.Open();
                NpgsqlCommand getinfo = new NpgsqlCommand("Select moviename,movietopic,catname,username from moviestable2 where moviename='"+moviename+"'", connection);
                NpgsqlDataReader readerinfo = getinfo.ExecuteReader();
                if (readerinfo.Read())
                {
                    richTextBox3.Text ="Movie' name : "+readerinfo["moviename"].ToString()+"\n \n Movie' Type : "+readerinfo["catname"]+"\n \n "+readerinfo["movietopic"]+"\n\n Writer : "+readerinfo["username"]+"\n \n";
                    isThere=(false);
                }
                connection.Close(); 
            }
            else { MessageBox.Show("Movie cannot found. Please, check the movie' name."); }


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
        
        private void Movie_Advices_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from filmcategories",connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            type_combobox.DisplayMember = "catname";
            type_combobox.ValueMember = "catid";
            
            type_combobox.DataSource = dt;
            connection.Close();
        }
        
        private void src_button_Click(object sender, EventArgs e)
        {
            string catidd = type_combobox.SelectedValue.ToString();
            int catid;
            Int32.TryParse(catidd,out catid);

            connection.Open();
            NpgsqlCommand getinfo = new NpgsqlCommand("Select moviename,movietopic,username from moviestable2 where catid=" + catid, connection);
            NpgsqlDataReader reader = getinfo.ExecuteReader();
            if (reader.Read())
            {
                richTextBox2.Text = "Movie name : "+reader["moviename"].ToString()+"\n \n"+reader["movietopic"].ToString()+"\n \n"+"Writer : "+reader["username"].ToString()+"\n"+"----------------------------------------"+"\n";
            }
            connection.Close();
        }
        int uuserid,movieid;
        int moviieid;
        private void button3_Click(object sender, EventArgs e)
        {
            richTextBox3.Text = "";
            richTextBox3.Visible = true;
            panel2.Visible = false;
            
            //control moviename
            string moviename = name.Text;
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("Select moviename,movieid from movies", connection);
            NpgsqlDataReader reader = control.ExecuteReader();

            while (reader.Read())
            {
                if (moviename == reader["moviename"].ToString())
                {
                    isThere = true;
                    string movieidd = reader["movieid"].ToString();
                    Int32.TryParse(movieidd,out moviieid);
                    break;
                }
                else
                    isThere = false;
            }
            connection.Close();
            if (isThere == true)
            {
                connection.Open();
                NpgsqlCommand getinfo = new NpgsqlCommand("Select content,username from mreplies where movieid='" + moviieid + "'", connection);
                NpgsqlDataReader readerinfo = getinfo.ExecuteReader();
                if (readerinfo.Read())
                {
                    richTextBox3.Text = "Movie' name : " + name.Text + "\n \n Reply : " + readerinfo["content"] + "\n\n Writer : " + readerinfo["username"] + "\n \n";
                    isThere = (false);
                }
                connection.Close();
            }
            else { MessageBox.Show("Movie cannot found. Please, check the movie' name."); }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Add_Movie transition = new Add_Movie();
            transition.Show();
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            Main transition = new Main();
            transition.Show();
            this.Hide();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            connection.Open();

            

            NpgsqlCommand getinfo3 = new NpgsqlCommand("Select userid from users where username='"+ Login.saveusername + "'", connection);
            NpgsqlDataReader reader3 = getinfo3.ExecuteReader();
            if (reader3.Read())
            {
                string useridd = reader3["userid"].ToString();
                 Int32.TryParse(useridd,out uuserid);
                connection.Close();
                connection.Open();
                NpgsqlCommand getinfo2 = new NpgsqlCommand("Select movieid from movies where moviename='" + movnametextBox.Text + "'", connection);
                NpgsqlDataReader reader2 = getinfo2.ExecuteReader();
                if (reader2.Read())
                {
                    string movieidd = reader2["movieid"].ToString();
                    Int32.TryParse(movieidd, out movieid);
                    connection.Close();
                    connection.Open();
                    NpgsqlCommand addnewmreply = new NpgsqlCommand("call mreply(" + movieid + "," + uuserid + ",'" + richTextBox1.Text + "')", connection);

                    addnewmreply.ExecuteNonQuery();

                    connection.Close();
                    MessageBox.Show("Your replies was added successfully");
                    richTextBox1.Text = "";
                    movnametextBox.Text = "";
                }
                else { MessageBox.Show("Movieid cannot found"); }
                connection.Close();

            }
            else { MessageBox.Show("Userid cannot found"); }
            

            


            
        }
    }
}
