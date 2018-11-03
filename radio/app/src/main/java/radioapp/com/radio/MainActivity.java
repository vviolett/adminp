package radioapp.com.radio;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {
    RadioManager radioManager;
    String streamURL = "http://hyades.shoutca.st:8043/stream";

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        radioManager = RadioManager.with(this);
        final Button button = findViewById(R.id.b_play);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                radioManager.playOrPause(streamURL);
            }
        });
    }

    @Override
    public void onStart() {
        super.onStart();
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        radioManager.unbind();
        super.onDestroy();
    }

    @Override
    protected void onResume() {
        super.onResume();
        radioManager.bind();
    }

    @Override
    public void onBackPressed() {
        finish();
    }

}
