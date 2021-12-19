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
    public partial class Messages : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Messages()
        {
            InitializeComponent();
        }

        private void Messages_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from categories", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            comboBox1.DisplayMember = "categoryname";
            comboBox1.ValueMember = "categoryid";
            comboBox2.DisplayMember = "categoryname";
            comboBox2.ValueMember = "categoryid";

            comboBox1.DataSource = dt;
            comboBox2.DataSource = dt;
            connection.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void myprofile_Click(object sender, EventArgs e)
        {
            My_Profile transition = new My_Profile();
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


        int catid, userid;
        private void button3_Click(object sender, EventArgs e)
        {
            string catidd=comboBox1.SelectedValue.ToString();
            Int32.TryParse(catidd, out catid);

            connection.Open();

            NpgsqlCommand getuserid = new NpgsqlCommand("select userid from users where username='"+Login.saveusername+"'",connection);
            NpgsqlDataReader reader = getuserid.ExecuteReader();
            if (reader.Read())
            {
                string useridd = reader["userid"].ToString();
                Int32.TryParse(useridd, out userid);
            }
            else lblsms.Text = "Userid cannot found";
            connection.Close();
            connection.Open();

            NpgsqlCommand addmessage = new NpgsqlCommand("call addnewmessage(@content,@userid,@catid)",connection);
            addmessage.Parameters.AddWithValue("@content", sharetxtBox.Text);
            addmessage.Parameters.AddWithValue("@userid", userid);
            addmessage.Parameters.AddWithValue("@catid", catid);
            addmessage.ExecuteNonQuery();

            lblsms.Text = "Message was sent successfully";
            connection.Close();
        }
        int catid2, id,id2,id3;

        private void bywrd_Click(object sender, EventArgs e)
        {
            string word = wordtxtBox.Text;
            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select messageid from getmessage where mcontent like '%" + word + "%' order by messageid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["messageid"].ToString();
                Int32.TryParse(idd, out id3);
            }
            else MessageBox.Show("Cannot found");
            connection.Close();
            string holder = "---------------- MESSAGES----------------\n\n";
            for (int i = id3; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getmessage = new NpgsqlCommand("select mcontent,username from getmessage where mcontent like '%" + word + "%' and messageid=" + i, connection);
                NpgsqlDataReader reader2 = getmessage.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = reader2["mcontent"] + "\n\nWriter : "+reader2["username"] +"------------------------------------------\n\n";
                    showtxtBox.Text = holder + hold;
                    holder = showtxtBox.Text;

                }
                connection.Close();

            }
        }

        private void byusr_Click(object sender, EventArgs e)
        {
            string usrname = usrtxtBox.Text;
            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select messageid from getmessage where username='" + usrname + "' order by messageid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["messageid"].ToString();
                Int32.TryParse(idd, out id2);
            }
            else MessageBox.Show("No user or He / She has not shared any messages.");
            connection.Close();
            string holder = "---------------- MESSAGES----------------\n\n";
            for (int i = id2; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getmessage = new NpgsqlCommand("select mcontent from getmessage where username='" + usrname + "' and messageid=" + i, connection);
                NpgsqlDataReader reader2 = getmessage.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = reader2["mcontent"] + "\n\n------------------------------------------\n\n";
                    showtxtBox.Text = holder + hold;
                    holder = showtxtBox.Text;

                }
                connection.Close();

            }
        }

        private void bycat_Click(object sender, EventArgs e)
        {
            string catidd = comboBox2.SelectedValue.ToString();
            Int32.TryParse(catidd, out catid2);

            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select messageid from messages where categoryid="+catid2+" order by messageid DESC limit 1",connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["messageid"].ToString();
                Int32.TryParse(idd, out id);
            }
            else MessageBox.Show("Cannot found messageid.");
            connection.Close();

            string holder = "---------------- MESSAGES----------------\n\n";
            for (int i = id; i > 0; i--)
            {
                
                connection.Open();
                NpgsqlCommand getmessage = new NpgsqlCommand("select mcontent,username from getmessage where categoryid="+catid2+" and messageid="+i,connection);
                NpgsqlDataReader reader2=getmessage.ExecuteReader();
                if(reader2.Read())
                {
                    string hold = reader2["mcontent"] + "\n\nWriter : " + reader2["username"] + "\n\n------------------------------------------\n\n";
                    showtxtBox.Text = holder+hold;
                    holder = showtxtBox.Text;
                    
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
