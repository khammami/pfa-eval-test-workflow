package com.example.android.hellotoast;

import androidx.test.ext.junit.rules.ActivityScenarioRule;
import androidx.test.ext.junit.runners.AndroidJUnit4;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.assertion.ViewAssertions.matches;
import static androidx.test.espresso.matcher.ViewMatchers.withId;
import static androidx.test.espresso.matcher.ViewMatchers.withText;

@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Rule
    public ActivityScenarioRule<MainActivity> activityRule = new ActivityScenarioRule<>(MainActivity.class);

    @Test
    public void testButtonText() {
        onView(withId(R.id.button_toast)).check(matches(withText("Say Hello")));
    }

    @Test
    public void testInitialCounter() {
        onView(withId(R.id.button_count)).perform(click());
        onView(withId(R.id.show_count)).check(matches(withText("1")));
    }

//    @Test
//    public void testButtonClickIncrementsCounterAndLaunchesNewActivity() throws Exception {
//
//        // Click the counter button to increment it
//        onView(withId(R.id.button_count)).perform(click());
//
//        // Get initial counter value
//        String initialCounterText = onView(withId(R.id.show_count)).check(matches(withText("1"))).toString();
//        int initialCounter = Integer.parseInt(initialCounterText);
//
//        // Click the button
//        onView(withId(R.id.button_toast)).perform(click());
//
//        // Assert that a new activity is launched
//        Intents.intended(hasExtras(BundleMatchers.hasValue(initialCounter)));
//
////        // Retrieve the counter value from the new activity (using reflection)
////        String className = Intents.getIntendedTargetClassName();
////        Method method = Class.forName(className).getMethod("getPassedCounterKey");
////        String counterKey = (String) method.invoke(null);
////        int counterInNewActivity = Intents.getIntExtra(className, counterKey, -1);
////
////        // Assert that the counter value is passed correctly
////        assertEquals(initialCounter + 1, counterInNewActivity);
//    }
}
