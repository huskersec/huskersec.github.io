---
title: "OSCP: Never Quit!"
date: 2017-09-22 19:54:04 -0400
categories: [Notes]
tags: [oscp, pentest, certification, red-team]
---

> Originally published on [Medium](https://medium.com/@huskersec/oscp-never-quit-47adeccfb13f)
> on 2017-09-22. Republished here as part of consolidating my writing onto this site.
{: .prompt-info }

What follows is, hopefully, a helpful overview and lessons learned of the
Penetration Testing with Kali Linux course and the associated, perhaps even
dreaded, OSCP exam. I passed the exam in June and was so elated and thankful to
have been accepted into the club of OSCP. I actually screamed a little when I
received the notification email but, uh, let's keep that a secret. Before we dive
into it, I just want to say that it was an amazing and rewarding experience that
I'll always be grateful for. The folks over at Offensive Security have cultivated
a great course I'll continually recommend to anyone interested in security or the
topics the course covers. Now, let's begin.

## I. Preparing for the Course

You don't necessarily have to but if you do want to spend a fair amount of time
preparing for the course, ensure you review the syllabus, available here:
[OSCP Syllabus](https://www.offensive-security.com/documentation/penetration-testing-with-kali.pdf).
Even just a little research into some of the topics mentioned in the syllabus will
definitely help and may ease any beginning growing pains you may have. In
addition, I downloaded
[Metasploitable v2](https://sourceforge.net/projects/metasploitable/files/Metasploitable2/),
an intentionally vulnerable Linux machine, and attempted to enumerate and exploit
the system as much as possible. Once I was feeling up to dedicating time to
studying, I signed up for the PWK course and began the journey to OSCP.

## II. Course Content

For the course content, Offensive Security provides a 300+ page manual as well as
videos that demonstrate the foundation methodologies in the penetration testing
process that you'll need to know: enumeration, exploitation, post-exploitation,
cleanup and reporting. I first watched all the videos and then I cracked open the
lab manual to begin working through that. In reviewing both the manual and the
videos, you get a grasp of the pentest methodology and tools/techniques to use to
complete certain steps of the process but heed my warning, you will absolutely
need to research so much more outside of the videos/manual, depending on your
experience, so be ready.

Throughout the manual, there are exercises that reinforce the topic(s) presented
throughout each chapter I found to be beneficial. I made it a point to
complete/document each exercise in the manual because they help with the learning
process and coupled with the lab penetration test report, it could result in 5
bonus points toward your exam. Once I was done with the manual and all exercises,
I then solely focused on attacking and rooting as many lab systems as possible,
covered in the next section.

## III. Lab Systems

Interacting with the lab systems, you'll find how well-thought-out and well-built
each and every system is. It's very clear how much time and effort the folks at
Offensive Security spent in designing each attack vector to effectively test your
skills in every phase of the attack. At times you may curse that pesky attack
vector and how much you potentially have to research to compromise the system but
once you do, it'll feel amazing and you'll most likely have learned something new.

For me, I began to build and tweak my methodology as I started compromising
systems in the lab. Using both the course manual and other techniques/tools
widely-available on the Internet, I perfected and finalized the methodology I had
created and began using it for every system I came across in the lab. Without a
proven, methodical way to assess and attack each system, it's very easy to get
confused and lose track of your progress which will only result in frustration,
wasted time and failure. Ensure you have a working methodology BEFORE you sit for
the exam; it will help out greatly.

The lab systems range in difficulty from default Metasploit remote root exploit to
OMGWTF, but they're all fun ;). Since each person is different, I won't venture to
say how much time you should spend in the lab but I spent enough time to compromise
25–30 systems. At that point, I felt confident enough to sit for the exam and had
seen enough differing operating systems that effectively tested my methodology. To
be safe, ensure you target and compromise a healthy amount of both Windows and
Linux to get used to specific commands/techniques for both OS' as you work your
way through the lab.

As you work through the lab, ensure you're documenting each step you take with
screenshots and any notes you think may be valuable in a penetration test report
or just in helping you remember steps taken at a later time. As I practiced in the
lab, I kept the exam documentation requirements in mind and got in the habit of
aligning my documentation with what was required for the exam. Compromising your
way through the lab provides a great opportunity to practice documentation and
determine what works best for you. In addition, documenting your exploitation of
at least 10 systems in a penetration test report when coupled with a course
exercises report will net an additional 5 points toward your exam; definitely
important if you fall just short of the points needed to pass the exam.

During my studying, there were multiple times when I'd get stuck on a problem and
just couldn't figure it out. If you're stuck, take a break and resume a little
later. Many times, I'd walk away, turn on a movie or TV show and research whatever
issue I was having while half-heartedly watching whatever was on. For me, it gave
me time to rest but also allowed me to continue researching and come up with new
ideas to try once I was ready to study again. Lastly, learn and become familiar
with multiple ways to accomplish a task. The ability to complete a particular task
may differ and be restricted in some way from one system to another so having
multiple options will be greatly beneficial to compromising each system you
target. To the exam…

## IV. Exam

The exam requires you earn a minimum of 70 points by compromising 5 targets over a
period of 23 hours and 45 minutes. The targets are weighted differently according
to difficulty so choose wisely in the time you have remaining. Then, the following
24 hours are allotted to allow for the generation and submission of the exam
penetration test report. Prior to the test, read through the
[exam guide](https://support.offensive-security.com/#!oscp-exam-guide.md) like a
billion times. It would be terrible to have spent the last 48 hours compromising
each system, tediously documenting every step and writing the report to have none
of it count because instructions clearly stated in the guide weren't followed.

For my exam, I scheduled it on a Friday morning at 10am. I was able to
successfully compromise two systems in the first couple of hours but then I slowed
as I ran into some troubles with the remaining systems. However, after pushing
through those issues, I was able to fully compromise another system and gain
low-privileged access to another. Due to my issues, I ended up taking close to the
maximum time and finished just before my VPN access was cut off. Finally, I went
to sleep for a couple of hours, wrote my exam report and had all three reports
submitted to Offensive Security prior to the 48 hour time limit. The following
Monday, I received the notification that I had passed, finally relaxed and stopped
checking my email constantly. :)

## V. Conclusion

The PWK course was the best training I've taken in my career. The manual, videos
and most importantly, the lab environment, effectively prepared me for the exam
and continuously taught me numerous new tools/techniques along the way. The tips
I've mentioned here definitely helped me out and I hope they help you as well;
after all, that's the point of this. Good luck and Try Harder!
