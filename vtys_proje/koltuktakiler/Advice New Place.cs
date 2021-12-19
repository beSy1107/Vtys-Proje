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
    public partial class Advice_New_Place : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Advice_New_Place()
        {
            InitializeComponent();
        }

        private void Advice_New_Place_Load(object sender, EventArgs e)
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
        int coc, cic;
        private void ok1_Click(object sender, EventArgs e)
        {
            button2.Visible = true;
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
        bool isThere;
        int userid;
        private void button1_Click(object sender, EventArgs e)
        {
            
            label9.Text = "";
            connection.Open();
            NpgsqlCommand getuserid = new NpgsqlCommand("select userid from users where username='"+Login.saveusername+"'",connection);
            NpgsqlDataReader readeruserid = getuserid.ExecuteReader();
            if (readeruserid.Read())
            {
                string useridd=readeruserid["userid"].ToString();
                Int32.TryParse(useridd , out userid);
            }


            connection.Close();

            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("select content from places",connection);
            NpgsqlDataReader reader = control.ExecuteReader();
            while(reader.Read())
            {
                if(richTextBox1.Text ==reader["content"].ToString() || richTextBox1.Text=="")
                {
                    isThere = false;
                    break;
                }else isThere = true;
            }
            connection.Close();
            if(isThere == false)
            {
                label9.Text = "This content is already registered.";
            }
            else
            {
                connection.Open();

                NpgsqlCommand addnewplace = new NpgsqlCommand("call addnewplace(@placename,@content,@citycode,@countrycode,@userid)",connection);

                addnewplace.Parameters.AddWithValue("@placename",textBox2.Text);
                addnewplace.Parameters.AddWithValue("@content", richTextBox1.Text);
                addnewplace.Parameters.AddWithValue("@citycode", cic);
                addnewplace.Parameters.AddWithValue("@countrycode", coc);
                addnewplace.Parameters.AddWithValue("@userid", userid);

                addnewplace.ExecuteNonQuery();

                connection.Close();
                MessageBox.Show("Added successfully");
                isThere = false;
                textBox2.Text = "";
                button3.Visible = false;
                ok1.Visible = true;
                button1.Visible = false;
                textBox2.Enabled = true;
                richTextBox1.Text = "";
            }


        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
            button3.Visible = false;
            button2.Visible = true;
            button1.Visible = false;
            ok1.Visible = true;
            textBox2.Enabled = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            label6.Text = "";
            label7.Text = "";
            string cicc = comboBox2.SelectedValue.ToString();
            Int32.TryParse(cicc, out cic);

            connection.Open();

            NpgsqlCommand control = new NpgsqlCommand("select placename from places", connection);
            NpgsqlDataReader reader=control.ExecuteReader();
            while(reader.Read())
            {
                if(textBox2.Text ==reader["placename"].ToString() || textBox2.Text=="")
                {
                    isThere = true;
                    break;
                }else isThere = false;
            }
            connection.Close();
            if(isThere==true)
            {
                label6.Text = "This placename is already registered.";
            }
            else
            {
                ok1.Visible = false;
                button2.Visible = false;
                button3.Visible = true;
                textBox2.Enabled = false;
                button1.Visible = true;
                label7.Text = "You can use this name that is not used yet.";
                isThere = true;
            }


        }
    }
}
