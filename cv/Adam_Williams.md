# Adam Williams's CV

- Email: [williams_adam@icloud.com](mailto:williams_adam@icloud.com)
- Location: Boulder, CO
- LinkedIn: [williams-adam](https://linkedin.com/in/williams-adam)
- GitHub: [awilliams](https://github.com/awilliams)


# Profile
Staff software engineer specializing in Go backend systems, building and owning distributed services at scale. Biased toward simple, durable code.

# Experience
## **Fastly**, Staff Software Engineer

Apr 2021 – present

- Design and own the Go backend for the [Secret Store](https://www.fastly.com/blog/announcing-the-fastly-secret-store-extending-edge-data-with-edge-secrets/) product, including its public API, deployed on Kubernetes.

- Lead the migration of the Config Store API out of a legacy monolith into a standalone Go service on Kubernetes, so it scales and ships features independently.

- Build the observability and monitoring that verified a safe migration of a Go configuration delivery system from eager to on-demand delivery across thousands of edge nodes, reclaiming the disk capacity needed to keep onboarding customers.

- Migrate [on-the-fly video packaging](https://www.fastly.com/products/perform/otfp) customers onto a new delivery configuration layer (VCL), letting Fastly ship packaging changes without customer involvement; support and extend the underlying Go service.

- Unblock the GA release of [ACLs on Compute](https://www.fastly.com/release-notes/q1-2025) by implementing hostcalls and configuration delivery; contribute further Compute platform features in Rust.

- Add Secret Store and Config Store commands to the [Fastly CLI](https://github.com/fastly/cli), the official tool customers use to deploy and configure services.



## **Comcast**, Senior Software Engineer (Engineer 4)

Feb 2015 – Apr 2021

- Designed an MPEG-TS parsing library in Go and built a video stream monitoring application on it, reporting metrics with Prometheus and deployed with Docker and Kubernetes; added an automated testing framework that improved accuracy and development speed.

- Built a Go decoder for set-top box commands from protocol specifications.

- Deployed services nationally across multiple data centers with Kubernetes and Helm; developed a custom CNI plugin.

- Built a network monitoring tool that uncovered a long-standing production DNS issue, then resolved it.

- Designed and built the native Go client for Apache Pulsar alongside the project's core maintainers; released as open source at [github.com/Comcast/pulsar-client-go](https://github.com/Comcast/pulsar-client-go).

- Selected for the Open Source Fellowship Program; received a top contributor award.



## **Cabify**, Senior Developer

Oct 2013 – Feb 2015

- Owned infrastructure for a service operating in four countries; provisioned and maintained servers on AWS and Linode with Ansible, and monitored them with InfluxDB.

- Delivered product features across Ruby on Rails, Node.js, and Go services, and built internal developer tooling.

- Introduced Go to the company, replacing Node.js services and improving reliability.



# Education
## **University of Minnesota**, BS in Mathematics -- Minneapolis, MN

**BS**



## **University of Minnesota**, BA in Spanish Studies -- Minneapolis, MN

**BA**



# Projects
## **[wifi-presence](https://github.com/awilliams/wifi-presence)**

Open-source OpenWrt package providing presence detection based on Wi-Fi client connections.



# Skills
**Languages:** Go (primary), Rust, Ruby

**Infrastructure:** Kubernetes, Helm, Docker, Prometheus, AWS, GCP, Ansible

**Domains:** Distributed systems, API backends, network protocols, video streaming, observability
