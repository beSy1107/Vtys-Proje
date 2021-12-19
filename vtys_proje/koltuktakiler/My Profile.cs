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
    public partial class My_Profile : Form
    {
        public My_Profile()
        {
            InitializeComponent();
        }
        //MENU KISMINDAKİ BUTONLARIN SAYFALARA YÖNLENDIRILMELERI
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
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        private void My_Profile_Load(object sender, EventArgs e)
        {
            connection.Open();

            NpgsqlCommand getinfo = new NpgsqlCommand("select * from general where username='"+Login.saveusername+"'",connection);
            NpgsqlDataReader reader = getinfo.ExecuteReader();

            if (reader.Read())
            {
                lblusername.Text = reader["username"].ToString();
                lblname.Text = reader["name"].ToString();
                lblsurname.Text = reader["surname"].ToString();
                lblrank.Text = reader["rankname"].ToString();
                lblhreplies.Text = reader["hreplies"].ToString();
                lblmessages.Text = reader["messages"].ToString();
                lblmovies.Text = reader["movies"].ToString();
                lblmreplies.Text = reader["mreplies"].ToString();
                lblplaces.Text = reader["places"].ToString();
                lblquestions.Text = reader["questions"].ToString();
                lblreplies.Text = reader["replies"].ToString();
                lblseries.Text = reader["series"].ToString();
                lblsreplies.Text = reader["sreplies"].ToString();
                connection.Close();
            }
            else MessageBox.Show("Cannot found user' informations.","Error");

            connection.Open();
            NpgsqlCommand getcombo = new NpgsqlCommand("select * from categories",connection);
            NpgsqlDataAdapter da= new NpgsqlDataAdapter(getcombo);
            DataTable dt= new DataTable();
            da.Fill(dt);
            comboBox1.DisplayMember = "categoryname";
            comboBox1.ValueMember = "categoryid";

            comboBox1.DataSource = dt;
            connection.Close();
        }
        int catidm, catidq,userid;
        bool isThere;

        private void refresh_Click(object sender, EventArgs e)
        {
            connection.Open();

            NpgsqlCommand getinfo = new NpgsqlCommand("select * from general where username='" + Login.saveusername + "'", connection);
            NpgsqlDataReader reader = getinfo.ExecuteReader();

            if (reader.Read())
            {
                lblusername.Text = reader["username"].ToString();
                lblname.Text = reader["name"].ToString();
                lblsurname.Text = reader["surname"].ToString();
                lblrank.Text = reader["rankname"].ToString();
                lblhreplies.Text = reader["hreplies"].ToString();
                lblmessages.Text = reader["messages"].ToString();
                lblmovies.Text = reader["movies"].ToString();
                lblmreplies.Text = reader["mreplies"].ToString();
                lblplaces.Text = reader["places"].ToString();
                lblquestions.Text = reader["questions"].ToString();
                lblreplies.Text = reader["replies"].ToString();
                lblseries.Text = reader["series"].ToString();
                lblsreplies.Text = reader["sreplies"].ToString();
                connection.Close();
            }
            else MessageBox.Show("Cannot found user' informations.", "Error");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string catidd = comboBox1.SelectedValue.ToString();
            Int32.TryParse(catidd, out catidq);

            //CONTROL
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("select qcontent from questions",connection);
            NpgsqlDataReader reader2 = control.ExecuteReader(); 
            while(reader2.Read())
            {
                if(richTextBox1.Text == reader2["qcontent"].ToString())
                {
                    isThere = false;
                    break;
                }else isThere = true;
            }
            connection.Close();
            if(isThere == false)
            {
                MessageBox.Show("This question was already added.","Error");
            }
            else
            {
                connection.Open();

                NpgsqlCommand getuserid = new NpgsqlCommand("Select userid from users where username ='"+Login.saveusername+"'", connection);
                NpgsqlDataReader reader = getuserid.ExecuteReader();

                if (reader.Read())
                {
                    string useridd = reader["userid"].ToString();
                    Int32.TryParse(useridd, out userid);
                }


                connection.Close();
                connection.Open();
                NpgsqlCommand addnewquestion = new NpgsqlCommand("call addnewquestion(@mcontent,@userid,@catid)", connection);
                addnewquestion.Parameters.AddWithValue("@mcontent", richTextBox1.Text);
                addnewquestion.Parameters.AddWithValue("@userid", userid);
                addnewquestion.Parameters.AddWithValue("@catid", catidq);
                addnewquestion.ExecuteNonQuery();
                connection.Close();
                MessageBox.Show("Added successfully");
                isThere = false;
            }


            
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string catidd=comboBox1.SelectedValue.ToString();
            Int32.TryParse(catidd, out catidm);
            //CONTROL
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("select mcontent from messages", connection);
            NpgsqlDataReader reader2 = control.ExecuteReader();
            while (reader2.Read())
            {
                if (richTextBox1.Text == reader2["mcontent"].ToString())
                {
                    isThere = false;
                    break;
                }
                else isThere = true;
            }
            connection.Close();
            if (isThere == false)
            {
                MessageBox.Show("This message was already added.", "Error");
            }
            else
            {
                connection.Open();

                NpgsqlCommand getuserid = new NpgsqlCommand("Select userid from users where username ='"+Login.saveusername+"'", connection);
                NpgsqlDataReader reader = getuserid.ExecuteReader();

                if (reader.Read())
                {
                    string useridd = reader["userid"].ToString();
                    Int32.TryParse(useridd, out userid);
                }


                connection.Close();
                connection.Open();
                NpgsqlCommand addnewmessage = new NpgsqlCommand("call addnewmessage(@mcontent,@userid,@catid)", connection);
                addnewmessage.Parameters.AddWithValue("@mcontent", richTextBox1.Text);
                addnewmessage.Parameters.AddWithValue("@userid", userid);
                addnewmessage.Parameters.AddWithValue("@catid", catidm);
                addnewmessage.ExecuteNonQuery();
                connection.Close();
                MessageBox.Show("Added successfully");
                isThere = false;
            }


            
        }
    }
}
