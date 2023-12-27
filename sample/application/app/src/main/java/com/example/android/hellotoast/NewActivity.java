package com.example.android.hellotoast;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class NewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new);
        TextView mShowMainCount = (TextView) findViewById(R.id.show_main_count);

        //get the current intent
        Intent intent = getIntent();

        //get the attached extras from the intent
        //we should use the same key as we used to attach the data.
        int mCount = intent.getIntExtra(MainActivity.COUNT_KEY,0);
        mShowMainCount.setText(Integer.toString(mCount));
    }
}