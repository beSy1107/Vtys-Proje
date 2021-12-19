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
    public partial class Questions : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Questions()
        {
            InitializeComponent();
        }

        private void aaq_button_Click(object sender, EventArgs e)
        {
            ask_panel.Visible = true;
            search_panel.Visible = false;
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from categories", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            askcat_button.DisplayMember = "categoryname";
            askcat_button.ValueMember = "categoryid";

            askcat_button.DataSource = dt;
            connection.Close();


        }

        private void sq_button_Click(object sender, EventArgs e)
        {
            search_panel.Visible = true;
            ask_panel.Visible = false;
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
       
        private void Questions_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from categories", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            qcat_.DisplayMember = "categoryname";
            qcat_.ValueMember = "categoryid";

            qcat_.DataSource = dt;
            connection.Close();
        }
        int catid, id, id2, id3;

        private void reply1_button_Click(object sender, EventArgs e)
        {
            reply_panel.Visible = true;
            show_panel.Visible = false;


        }
        bool isThere;
        private void show1_button_Click(object sender, EventArgs e)
        {
            reply_panel.Visible = false;
            show_panel.Visible = true;
        }
        int userid,qID,qID2,id5;
        int cateid;
        int quserid;
        private void send_button_Click(object sender, EventArgs e)
        {
            string content = sendq_button.Text;
            string cateidd = askcat_button.SelectedValue.ToString();
            Int32.TryParse(cateidd, out cateid);
            connection.Open();

            NpgsqlCommand getuserid = new NpgsqlCommand("select userid from users where username='"+Login.saveusername+"'",connection);
            NpgsqlDataReader reader2 = getuserid.ExecuteReader();
            if (reader2.Read())
            {
                string quseridd = reader2["userid"].ToString();
                Int32.TryParse(quseridd, out quserid);
            }
            else MessageBox.Show("Userid cannot found");

            connection.Close();
            connection.Open();
                NpgsqlCommand control = new NpgsqlCommand("select qcontent from questions",connection);
                NpgsqlDataReader reader = control.ExecuteReader();
                
            while(reader.Read())
            {
                if(content == reader["qcontent"].ToString())
                {
                    isThere = false;
                    break;
                }else isThere = true;
            }
            connection.Close();
            
            if (isThere == true)
            {
                connection.Open();
                NpgsqlCommand addnewq = new NpgsqlCommand("call addnewquestion('"+content+"',"+quserid+","+cateid+")", connection);
                addnewq.ExecuteNonQuery();
                MessageBox.Show("Added successfully.");
                connection.Close();
                isThere =false;
               
            }else { MessageBox.Show("This question already asked."); }


        }

        private void reply_button_Click(object sender, EventArgs e)
        {
            string qId = replyqid.Text;
            Int32.TryParse(qId, out qID);
            string reply = reply_rtb.Text;

            connection.Open();

            NpgsqlCommand getuserid = new NpgsqlCommand("select userid from users where username='" + Login.saveusername + "'", connection);
            NpgsqlDataReader reader = getuserid.ExecuteReader();
            if (reader.Read())
            {
                string useridd = reader["userid"].ToString();
                Int32.TryParse(useridd, out userid);
            }
            else MessageBox.Show("Cannot Found Userid");

            connection.Close();
            connection.Open();

            NpgsqlCommand addquestion = new NpgsqlCommand("call addnewreply('"+reply+"',"+qID+","+userid+")",connection);
            addquestion.ExecuteNonQuery();
            MessageBox.Show("Successful");

            connection.Close();
        }

        private void show_button_Click(object sender, EventArgs e)
        {
            string qId =showqid.Text;
            Int32.TryParse (qId, out qID2);
            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select replyid from getreply where questionid=" + qID2 + " order by replyid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["replyid"].ToString();
                Int32.TryParse(idd, out id5);
            }
            else MessageBox.Show("No reply or question_id is false");
            connection.Close();
            string holder = "---------------- Replies----------------\n\n";
            for (int i = id5; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getreplies = new NpgsqlCommand("select rcontent,username from getreply where replyid=" + i + " and questionid=" + qID2, connection);
                NpgsqlDataReader reader2 = getreplies.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = "Writer : " + reader2["username"] + "\n\n" + reader2["rcontent"] + "\n\n------------------------------------------\n\n";
                    richTextBox2.Text = holder + hold;
                    holder = richTextBox2.Text;

                }
                connection.Close();

            }


        }

        private void byword_button_Click(object sender, EventArgs e)
        {
            string word = wordtxtBox.Text;
            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select questionid from getquestion where qcontent like '%" + word + "%' order by questionid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["questionid"].ToString();
                Int32.TryParse(idd, out id3);
            }
            else MessageBox.Show("Cannot found word");
            connection.Close();
            string holder = "---------------- QUESTIONS----------------\n\n";
            for (int i = id3; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getquestion = new NpgsqlCommand("select questionid,qcontent,username from getquestion where qcontent like '%" + word + "%' and questionid=" + i, connection);
                NpgsqlDataReader reader2 = getquestion.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = "Q_Id : " + reader2["questionid"] + "\n\n" + reader2["qcontent"] + "\n\nWriter : " + reader2["username"] + "------------------------------------------\n\n";
                    richTextBox1.Text = holder + hold;
                    holder = richTextBox1.Text;

                }
                else MessageBox.Show("Cannot found");
                connection.Close();

            }
        }

        private void byusr_button_Click(object sender, EventArgs e)
        {
            string usrname = usrtxtBox.Text;
            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select questionid from getquestion where username='" + usrname + "' order by questionid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["questionid"].ToString();
                Int32.TryParse(idd, out id2);
            }
            else MessageBox.Show("No user or He / She has not shared any questions.");
            connection.Close();
            string holder = "---------------- QUESTIONS----------------\n\n";
            for (int i = id2; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getquestion = new NpgsqlCommand("select questionid,qcontent from getquestion where username='" + usrname + "' and questionid=" + i, connection);
                NpgsqlDataReader reader2 = getquestion.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = "Q_Id : " + reader2["questionid"] + "\n\n" + reader2["qcontent"] + "\n\n------------------------------------------\n\n";
                    richTextBox1.Text = holder + hold;
                    holder = richTextBox1.Text;

                }
                else MessageBox.Show("cannot found");
                connection.Close();

            }
        }

        private void bycat_button_Click(object sender, EventArgs e)
        {
            string catidd = qcat_.SelectedValue.ToString();
            Int32.TryParse(catidd, out catid);

            connection.Open();
            NpgsqlCommand findlastnmbr = new NpgsqlCommand("select questionid from questions where categoryid=" + catid + " order by questionid DESC limit 1", connection);
            NpgsqlDataReader reader = findlastnmbr.ExecuteReader();
            if (reader.Read())
            {
                string idd = reader["questionid"].ToString();
                Int32.TryParse(idd, out id);
            }
            else MessageBox.Show("Cannot found questionid.");
            connection.Close();

            string holder = "---------------- QUESTIONS----------------\n\n";
            for (int i = id; i > 0; i--)
            {

                connection.Open();
                NpgsqlCommand getquestion = new NpgsqlCommand("select questionid,qcontent,username from getquestion where categoryid=" + catid + " and questionid=" + i, connection);
                NpgsqlDataReader reader2 = getquestion.ExecuteReader();
                if (reader2.Read())
                {
                    string hold = "Q_Id : " + reader2["questionid"] + "\n\n" + reader2["qcontent"] + "\n\nWriter : " + reader2["username"] + "\n\n------------------------------------------\n\n";
                    richTextBox1.Text = holder + hold;
                    holder = richTextBox1.Text;

                }
                else MessageBox.Show("cannot found");
                connection.Close();
            }
        }
    }
}
