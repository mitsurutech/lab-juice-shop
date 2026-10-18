# OWASP Juice Shop lab with Docker Compose: learn web application security by attacking an insecure online shop

[English](README.md) | [Français](README.fr.md) | [日本語](README.ja.md) | [Español](README.es.md)

[![check](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-juice-shop/actions/workflows/check.yml)

A ready-made **web application security lab** for classrooms, from the [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning), where schools and colleges give every student their own databases, containers and terminal in the browser. Each student gets their own copy of **OWASP Juice Shop**, an online shop that is insecure on purpose, with around a hundred challenges across the [OWASP Top 10](https://owasp.org/www-project-top-ten/): injection, broken authentication, broken access control, cross-site scripting, security misconfiguration and more. They find the weaknesses, **explain why each works and how the code should have been written**, and hand in evidence, with nothing installed and no risk to anybody else's machine.

It is one `docker-compose` file, `compose.yaml`, and it runs the same on your own machine as it does on the platform, where every student gets a private copy with no way out to the internet.

## The one rule

**Attack your own copy and nothing else.** Everything in this lab runs inside your own private copy, which has no route to the internet and none to any other student, so the only thing you can reach is the application the lab started for you. Never point a tool at a website, a network or a machine you do not own, in a lab or anywhere else: in the UK that is an offence under the [Computer Misuse Act 1990](https://www.legislation.gov.uk/ukpga/1990/18/contents), and most countries have a law like it. Learning how weaknesses work is how you build software that does not have them, and a good first conversation in a class is why this rule exists and what responsible disclosure looks like.

## What is in it

| Service | Image | Memory | What it is |
| --- | --- | --- | --- |
| `juice-shop` | [`bkimminich/juice-shop:v20.3.0`](https://hub.docker.com/r/bkimminich/juice-shop) | 512 MB | the shop, on port 3000, running as an unprivileged account (user 65532) with no capabilities |

It starts in a few seconds and uses roughly 100 MB when lightly used; a class using it hard will use more.

The images are third-party programs, run unmodified from the projects' own public images and pinned to a version (never `latest`), so the lab does not change under a class between one lesson and the next. Nothing is built here and nothing from this repository is distributed in them.

## Using it on the platform

The [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning) gives every student their own copy of a lab, in the browser, with a terminal beside it.

**To try it:** open the [container page](https://mitsurutech.co.uk/container), find this lab in **Sample labs** and press Start. No account is needed to try one.

**To set it as work for a class:**

1. In your module, make a task of type **Lab** and choose **In a GitHub repository**.
2. Give `https://github.com/mitsurutech/lab-juice-shop` with the branch `main`. The compose file is the default, `compose.yaml`. Fork the repository first if you want to change the file.
3. Publish. Every student's copy starts from the commit you published, so a later change here does not alter a lab already set.
4. Say in the task what to hand in (see [For teachers](#for-teachers)), and assign it like any other task.

The help manual's [guide to the security labs](https://mitsurutech.co.uk/help/security-labs) and its [guide to container labs](https://mitsurutech.co.uk/help/labs) cover the rest: what a compose file may say, how much memory a copy gets, and how a teacher opens, watches and marks a student's copy.

No college account yet? [Your first year is free](https://mitsurutech.co.uk/pricing) for up to 50 students, and [signing up](https://mitsurutech.co.uk/signup) takes an email address.

## Running it on your own machine

You need Docker with the Compose plugin. The first start downloads the images.

```bash
docker compose -f compose.yaml -f local.yaml up
```

Open <http://localhost:3000> for the shop.

`local.yaml` publishes the ports on `127.0.0.1` only, so the lab is reachable from your own computer and from nowhere else. Stop it with `Ctrl-C`, and remove it with `docker compose -f compose.yaml -f local.yaml down -v`. Run it on a machine you are happy to attack from: the application is insecure on purpose.

## Working through it

1. **Open the shop** (on the platform, press **Open** on the lab's page) and look around as a customer would: register, add things to the basket, read the reviews.
2. **Find the Score Board.** It lists every challenge by difficulty and turns each green when it is solved, and it is not linked from anywhere: finding it is the first challenge.
3. **Work up by difficulty.** The challenges cover the OWASP Top 10: injection, broken authentication, broken access control, cross-site scripting, security misconfiguration and more. Look at what the browser sends and receives, read what the page's own code does, and ask of every input what the program trusts about it. The Score Board's hints go further, and a student who has tried first learns more from them.
4. **Keep your place.** The shop forgets its state when the lab stops, so a student who will carry on tomorrow copies the **continue code** the Score Board offers.

## For teachers

Nothing in this lab is marked automatically. The student hands in evidence and you mark it, the way you mark any other lab.

**Ask for evidence in two halves.** First, proof of the work: a screenshot of the solved challenges on the Score Board, with the lab's own address visible in the browser so it is clearly their copy. Second, the understanding: for each one, a written explanation in their own words of what the weakness is, the exact input they used and why it worked, what an attacker could do with it, and how the code should have been written. The second half tells you whether it was understood or copied from a walkthrough. For stronger work ask for the fix as well as the attack.

**Where it sits in a course.** Juice Shop suits the OWASP Top 10 in a realistic application: threats and vulnerabilities, injection, authentication and session weaknesses, access control, cryptographic failures and security misconfiguration, and vulnerability assessment as a method. It also supports the legal and ethical side of a unit: authorisation and scope, the Computer Misuse Act 1990 and responsible disclosure. Check your own awarding body's unit for the exact wording; none is quoted here.

**Who sees what.** These labs are often used with students aged 16 and 17. A copy is private to the student who started it. A member of staff who teaches the module can open it to see what the student has done, and opening a student's work is written to the access log, which the student can read.

## What does not work in a lab

A small number of challenges need the internet or an AI service, and cannot be solved in a lab, which has no way out. The shop's state is kept in memory, so it is gone when the lab stops: use the continue code to carry on. It is given 512 MB.

## Troubleshooting

- **The shop does not open straight after Start.** Wait a few seconds and press Open again: the lab reports itself ready only once the shop answers.
- **On your own machine, port 3000 is already in use.** Change the left-hand number in `local.yaml`, for example `127.0.0.1:3001:3000`, and open that port instead.
- **A challenge needs the internet.** It cannot be solved here, by design.

## Checking the lab

`test/check.sh` starts the lab the way the platform's runner starts every service (all capabilities dropped, `no-new-privileges`, a process limit, memory limits, and no way out to the internet) and then checks from inside its network what this page promises. It needs Docker and runs on every push, which is the badge at the top.

```bash
test/check.sh
```

## Versions and third-party licences

[OWASP Juice Shop](https://github.com/juice-shop/juice-shop) is MIT licensed. The image is `bkimminich/juice-shop:v20.3.0`.

## Licence

This work is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). You may share it and adapt it for learning and teaching, if you credit Mitsuru Technologies Ltd, do not use it commercially, and share anything you make from it under the same licence. The full text is in the `LICENSE` file. It covers the compose file, the tests and this documentation. The application inside keeps the licence of its own project, linked above.

## About

Made by [Mitsuru Technologies](https://mitsurutech.co.uk) for the [MitsuruTech Learning Platform](https://mitsurutech.co.uk/learning): Python, Java, Go, Node, SQL and Linux in the browser for schools and colleges, with container labs, web apps deployed from GitHub, and quizzes that mark themselves. Try code with no account in the [playground](https://mitsurutech.co.uk/playground).

More labs from the same place: [lab-juice-shop](https://github.com/mitsurutech/lab-juice-shop), [lab-dvwa](https://github.com/mitsurutech/lab-dvwa), [lab-webgoat](https://github.com/mitsurutech/lab-webgoat), [lab-mysql-phpmyadmin](https://github.com/mitsurutech/lab-mysql-phpmyadmin), [lab-git-gitea](https://github.com/mitsurutech/lab-git-gitea) and [lab-sample](https://github.com/mitsurutech/lab-sample).
