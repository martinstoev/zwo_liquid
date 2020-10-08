# ZWO Liquid

This project enriches Zwift ZWO files with liquid template
capabilities. The main reason to do this is to introduce custom
variables for your desired zones and allow you more control over the
steps without repetition. The Zones are hardcoded, as they are
relative to the FTP set in your Zwift profile. If you dislike the
defaults, feel free to edit the files directly.

## Install

Install Ruby and install liquid.

```
bundle install
```

## Usage

Prepare a new ZWO file with your changes. You can use the
template/master.zwo file as reference. Next to the default liquid
commands (see: https://shopify.github.io/liquid/) you can use the
duration filter. This filter allows you to enter colon seperated times
so you don't need to calculate the seconds for each step. This means
you can enter {% duration 1:15:00 %} if you want to ride that step for
1 hour and 15 minutes.

Here is an example.

```
<workout_file>
  <author>M.Stoev</author>
  <name>CW 25 TUE Endurance Ride</name>
  <description></description>
  <sportType>bike</sportType>
  <workout>
    <SteadyState Duration="{% duration 10:00 %}" Power="{{Z1}}" pace="0"/>
    <SteadyState Duration="{% duration 1:00:00 %}" Power="{{Z2}}" pace="0"/>
  </workout>
</workout_file>
```

You can use all supported Zwift workout elements and attributes. The
easiest way to see supported elements is to create some workouts with
Zwift and inspect the resulting files in your
`~/Documents/Zwift/Workouts/<ID>/` folder. All workouts are saved as
ZWO files. You can also checkout an unofficial documentation here:
[Zwift Workout File Tag Reference](https://github.com/h4l/zwift-workout-file-reference/blob/master/zwift_workout_file_tag_reference.md).

In my expericence, the easiest and most flexibile way is use
`SteadyState` attributes and modify the duration and power. If you
have intervals just copy paste the steps or use liquid control
structures.

```
{% for i in (1..4) %}
<SteadyState Duration="{% duration 1:00 %}" Power="{{Z4}}" pace="0"/>
<SteadyState Duration="{% duration 3:00 %}" Power="{{Z1}}" pace="0"/>
{% endfor %}
<SteadyState Duration="{% duration 10:00 %}" Power="{{Z2}}" pace="0"/>
{% for i in (1..4) %}
<SteadyState Duration="{% duration 1:00 %}" Power="{{Z4}}" pace="0"/>
<SteadyState Duration="{% duration 3:00 %}" Power="{{Z1}}" pace="0"/>
{% endfor %}
```

The workout above consists of two interval blocks that alternate
between Z4 and Z1 4 times and are connected with a Z2 break in
between.

Once you have your ZWO file ready you can run the script
individually. The output will be printed to STDOUT, but you can easily
store the results in a new file.

```
ruby ./script.rb my_workout.zwo.liquid > my_workout.zwo
```

To make sure that Zwift plays nicely with your filenames only use
alphanumeric characters and use the underscore (`_`) instead of
spaces. Limit your filenames within the workout directory to 16
characters.

I recommend to name your liquid files differently than your workout
files (e.g. .liquid) so you don't mix them up. During the creation
part of your workout it's very convenient to just print out the
results to STDOUT.

```
ruby ./script.rb my_workout.zwo.liquid
```
